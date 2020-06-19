#!/bin/bash

cd user_program
./slave 10 ../output/sample_output/sample_output_1/target_file_1 ../output/sample_output/sample_output_1/target_file_2 ../output/sample_output/sample_output_1/target_file_3 ../output/sample_output/sample_output_1/target_file_4 ../output/sample_output/sample_output_1/target_file_5 ../output/sample_output/sample_output_1/target_file_6 ../output/sample_output/sample_output_1/target_file_7 ../output/sample_output/sample_output_1/target_file_8 ../output/sample_output/sample_output_1/target_file_9 ../output/sample_output/sample_output_1/target_file_10 fcntl 127.0.0.1
./slave 1 ../output/sample_output/sample_output_2/target_file fcntl 127.0.0.1
./slave 1 ../output/sample_output/sample_output_3/newdata.txt fcntl 127.0.0.1
