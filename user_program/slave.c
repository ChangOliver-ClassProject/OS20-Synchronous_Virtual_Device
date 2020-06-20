#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <fcntl.h>
#include <sys/ioctl.h>
#include <errno.h>
#include <sys/mman.h>
#include <sys/stat.h>
#include <sys/types.h>
#include <sys/time.h>

#define PAGE_SIZE 4096
#define BUF_SIZE 512

void printDmesg(int dev_fd, const unsigned long file_address) {
	ioctl(dev_fd, 0x12345676, file_address);
}

int main (int argc, char* argv[])
{
	char buf[BUF_SIZE];
	int i, dev_fd, file_fd;// the fd for the device and the fd for the input file
	size_t ret, file_size = 0, total_size = 0, data_size = -1, offset = 0;
	char file_name[50];
	char method[20];
	char ip[20];
	struct timeval start;
	struct timeval end;
	double trans_time; //calulate the time between the device is opened and it is closed
	char *kernel_address, *file_address;
	int N;

	N = atoi(argv[1]);
	strcpy(method, argv[argc-2]);
	strcpy(ip, argv[argc-1]);

	if((dev_fd = open("/dev/slave_device", O_RDWR)) < 0) {//should be O_RDWR for PROT_WRITE when mmap()
		perror("failed to open /dev/slave_device\n");
		return 1;
	}
	gettimeofday(&start ,NULL);
	for (int i = 0; i < N; i++) {
		offset = 0;
		file_size = 0;

		if((file_fd = open(argv[2+i], O_RDWR | O_CREAT | O_TRUNC)) < 0) {
			fprintf(stderr, "file: %s\n", argv[2+i]);
			perror("failed to open input file\n");
			return 1;
		}
		if(ioctl(dev_fd, 0x12345677, ip) == -1) {	//0x12345677 : connect to master in the device
			perror("ioctl create slave socket error\n");
			return 1;
		}
	
		long mmap_size = sysconf(_SC_PAGE_SIZE);
		switch(method[0]) {
			case 'f': //fcntl : read()/write()
				do {
					ret = read(dev_fd, buf, sizeof(buf)); // read from the the device
					write(file_fd, buf, ret); //write to the input file
					file_size += ret;
				} while(ret > 0);
				break;
			case 'm':
				while ((ret = read(dev_fd, buf, sizeof(buf))) > 0) {
					if (file_size % mmap_size == 0) {
						ftruncate(file_fd, file_size + mmap_size);
						if (file_size != 0) {
							printDmesg(file_fd, (unsigned long)file_address);
							munmap(file_address, mmap_size);
						}
						if((file_address = mmap(NULL, mmap_size, PROT_READ | PROT_WRITE, MAP_SHARED, file_fd, file_size)) == MAP_FAILED) {
							perror("mapping output file");
							return 1;
						}
					}
					memcpy(&file_address[file_size % mmap_size], buf, ret);
					file_size += ret;
				};
				ftruncate(file_fd, file_size);

				printDmesg(file_fd, (unsigned long)file_address);
				munmap(file_address, mmap_size);
				break;
		}

		total_size += file_size;
		if(ioctl(dev_fd, 0x12345679) == -1) { // end receiving data, close the connection
			perror("ioclt client exits error\n");
			return 1;
		}

		// ../output/sample_output_1/target_file_1 ../output/sample_output_1/target_file_2

		char cmd[512] = {0};
		sprintf(cmd, "cp ../input/sample_input_%c/* ../output/sample_output_%c", argv[2][24], argv[2][24]);
		system(cmd);

		close(file_fd);
	}
	close(dev_fd);
	gettimeofday(&end, NULL);
	trans_time = (end.tv_sec - start.tv_sec)*1000 + (end.tv_usec - start.tv_usec)*0.0001;
	printf("Transmission time: %lf ms, File size: %lu bytes\n", trans_time, total_size);
	return 0;
}