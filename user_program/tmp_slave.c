#include <stdio.h>
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
int main (int argc, char* argv[]) {
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

	if( (dev_fd = open("/dev/slave_device", O_RDWR)) < 0) {//should be O_RDWR for PROT_WRITE when mmap()
		perror("failed to open /dev/slave_device\n");
		return 1;
	}
	gettimeofday(&start ,NULL);

	for (int i = 0; i < N; i++) {
		if( (file_fd = open(argv[2+i], O_RDWR | O_CREAT | O_TRUNC)) < 0) {
			fprintf(stderr, "file: %s\n", argv[2+i]);
			perror("failed to open input file\n");
			return 1;
		}

		if(ioctl(dev_fd, 0x12345677, ip) == -1) {	//0x12345677 : connect to master in the device
			perror("ioctl create slave socket error\n");
			return 1;
		}

	    write(1, "ioctl success\n", 14);

		switch(method[0]) {
			case 'f'://fcntl : read()/write()
				do {
					ret = read(dev_fd, buf, sizeof(buf)); // read from the the device
					write(file_fd, buf, ret); //write to the input file
					file_size += ret;
				} while(ret > 0);
				break;
			case 'm':
				while(ret = ioctl(dev_fd, 0x12345678) > 0) {
					if(posix_fallocate(file_fd, offset, ret) != 0) {
						perror("posix_fallocate error");
						return 1;
					}
					file_address = mmap(NULL, ret, PROT_WRITE, MAP_SHARED, file_fd, offset);
					kernel_address = mmap(NULL, ret, PROT_READ, MAP_SHARED, dev_fd, offset);
					memcpy(file_address, kernel_address, ret);
					offset += ret;
				}
				file_size = offset;
				//munmap(dst, mmap_size);
				break;
		}

		total_size += file_size;

		if(ioctl(dev_fd, 0x12345679) == -1) { // end receiving data, close the connection
			perror("ioclt client exits error\n");
			return 1;
		}
	}

	gettimeofday(&end, NULL);
	trans_time = (end.tv_sec - start.tv_sec)*1000 + (end.tv_usec - start.tv_usec)*0.0001;
	printf("Transmission time: %lf ms, File size: %lu bytes\n", trans_time, total_size / 8);

	int output_fd;
	char output_path[50] = {0};
	sprintf(output_path, "../output/sample_output_%c/fcntl_result.txt", argv[2][24]);
	printf("%s\n", output_path);
	if ((output_fd = open(output_path, O_RDWR | O_CREAT | O_TRUNC)) < 0) {
		fprintf(stderr, "file: %s\n", output_path);
		perror("failed to open output file\n");
		return 1;
	}


	char output_msg[128] = {0};
	sprintf(output_msg, "Transmission time: %lf ms, File size: %lu bytes\n", trans_time, total_size / 8);
	write(output_fd, output_msg, strlen(output_msg)); //write to the input file

	close(output_fd);
	close(file_fd);
	close(dev_fd);
	return 0;
}


