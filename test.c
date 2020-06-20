#include <stdio.h>
int main(){
	FILE *fp;
	char str1[] = "group35 data\n";
	char str2[] = "OS SOS plz\n";
	fp = fopen("newdata.txt", "w");
	for (int i = 0; i < 4000000; i++){
		fputs(str1, fp);
		fputs(str2, fp);
	}
	fclose(fp);
	return 0;
}









