#!/bin/bash

./compile.sh
clear
cd user_program
echo Sending sample 1 with file I/O
./master 10 ../input/sample_input_1/target_file_1 ../input/sample_input_1/target_file_2 ../input/sample_input_1/target_file_3 ../input/sample_input_1/target_file_4 ../input/sample_input_1/target_file_5 ../input/sample_input_1/target_file_6 ../input/sample_input_1/target_file_7 ../input/sample_input_1/target_file_8 ../input/sample_input_1/target_file_9 ../input/sample_input_1/target_file_10 fcntl
echo Sending sample 2 with file I/O
./master 1 ../input/sample_input_2/target_file fcntl
echo Sending sample 3 with file I/O
./master 1 ../input/sample_input_3/newdata.txt fcntl

echo Sending sample 1 with mmap I/O
./master 10 ../input/sample_input_1/target_file_1 ../input/sample_input_1/target_file_2 ../input/sample_input_1/target_file_3 ../input/sample_input_1/target_file_4 ../input/sample_input_1/target_file_5 ../input/sample_input_1/target_file_6 ../input/sample_input_1/target_file_7 ../input/sample_input_1/target_file_8 ../input/sample_input_1/target_file_9 ../input/sample_input_1/target_file_10 mmap
echo Sending sample 2 with mmap I/O
./master 1 ../input/sample_input_2/target_file mmap
echo Sending sample 3 with mmap I/O
./master 1 ../input/sample_input_3/newdata.txt mmap
./clean.sh