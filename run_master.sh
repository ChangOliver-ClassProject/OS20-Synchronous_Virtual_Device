#!/bin/bash

./compile.sh
cd user_program
echo Running sample 1
./master 10 ../input/sample_input_1/target_file_1 ../input/sample_input_1/target_file_2 ../input/sample_input_1/target_file_3 ../input/sample_input_1/target_file_4 ../input/sample_input_1/target_file_5 ../input/sample_input_1/target_file_6 ../input/sample_input_1/target_file_7 ../input/sample_input_1/target_file_8 ../input/sample_input_1/target_file_9 ../input/sample_input_1/target_file_10 mmap
echo Running sample 2
./master 1 ../input/sample_input_2/target_file mmap
echo Running sample 3
./master 1 ../input/sample_input_3/newdata.txt mmap
