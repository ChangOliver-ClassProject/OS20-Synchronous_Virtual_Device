#!/bin/bash

cd user_program
echo Running sample 1
./slave 10 ../output/sample_output_1/target_file_1.txt ../output/sample_output_1/target_file_2.txt ../output/sample_output_1/target_file_3.txt ../output/sample_output_1/target_file_4.txt ../output/sample_output_1/target_file_5.txt ../output/sample_output_1/target_file_6.txt ../output/sample_output_1/target_file_7.txt ../output/sample_output_1/target_file_8.txt ../output/sample_output_1/target_file_9.txt ../output/sample_output_1/target_file_10.txt fcntl 127.0.0.1
echo Running sample 2
./slave 1 ../output/sample_output_2/target_file.txt fcntl 127.0.0.1
echo Running sample 3
./slave 1 ../output/sample_output_3/newdata.txt fcntl 127.0.0.1
