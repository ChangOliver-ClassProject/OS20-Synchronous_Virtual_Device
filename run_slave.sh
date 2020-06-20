#!/bin/bash

cd user_program
echo Recving sample 1 with file I/O
./slave 10 ../output/sample_output_1/target_file_1.txt ../output/sample_output_1/target_file_2.txt ../output/sample_output_1/target_file_3.txt ../output/sample_output_1/target_file_4.txt ../output/sample_output_1/target_file_5.txt ../output/sample_output_1/target_file_6.txt ../output/sample_output_1/target_file_7.txt ../output/sample_output_1/target_file_8.txt ../output/sample_output_1/target_file_9.txt ../output/sample_output_1/target_file_10.txt fcntl 127.0.0.1 2>&1 | tee ../output/sample_output_1/fcntl_result.txt
echo Recving sample 2 with file I/O
./slave 1 ../output/sample_output_2/target_file.txt fcntl 127.0.0.1 2>&1 | tee ../output/sample_output_2/fcntl_result.txt
echo Recving sample 3 with file I/O
./slave 1 ../output/sample_output_3/newdata.txt fcntl 127.0.0.1 2>&1 | tee ../output/sample_output_3/fcntl_result.txt

echo Recving sample 1 with mmap I/O
./slave 10 ../output/sample_output_1/target_file_1.txt ../output/sample_output_1/target_file_2.txt ../output/sample_output_1/target_file_3.txt ../output/sample_output_1/target_file_4.txt ../output/sample_output_1/target_file_5.txt ../output/sample_output_1/target_file_6.txt ../output/sample_output_1/target_file_7.txt ../output/sample_output_1/target_file_8.txt ../output/sample_output_1/target_file_9.txt ../output/sample_output_1/target_file_10.txt mmap 127.0.0.1  2>&1 | tee ../output/sample_output_1/mmap_result.txt
dmesg -t | grep master | tee ../output/sample_output_1/dmesg.txt
dmesg -t | grep slave | tee -a ../output/sample_output_1/dmesg.txt
dmesg -c
echo Recving sample 2 with mmap I/O
./slave 1 ../output/sample_output_2/target_file.txt mmap 127.0.0.1 2>&1 | tee ../output/sample_output_2/mmap_result.txt
dmesg -t | grep master | tee ../output/sample_output_2/dmesg.txt
dmesg -t | grep slave | tee -a ../output/sample_output_2/dmesg.txt
dmesg -c
echo Recving sample 3 with mmap I/O
./slave 1 ../output/sample_output_3/newdata.txt mmap 127.0.0.1 2>&1 | tee ../output/sample_output_3/mmap_result.txt
dmesg -t | grep master | tee ../output/sample_output_3/dmesg.txt
dmesg -t | grep slave | tee -a ../output/sample_output_3/dmesg.txt
dmesg -c