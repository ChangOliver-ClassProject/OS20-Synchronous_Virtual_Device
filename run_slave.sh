#!/bin/bash

cd user_program
clear
echo Receiving sample 1 with file I/O
./slave 10 ../output/sample_output_1/target_file_1 ../output/sample_output_1/target_file_2 ../output/sample_output_1/target_file_3 ../output/sample_output_1/target_file_4 ../output/sample_output_1/target_file_5 ../output/sample_output_1/target_file_6 ../output/sample_output_1/target_file_7 ../output/sample_output_1/target_file_8 ../output/sample_output_1/target_file_9 ../output/sample_output_1/target_file_10 fcntl 127.0.0.1 2>&1 | tee ../output/sample_output_1/fcntl_result.txt
echo Diffing input and output
diff ../input/sample_input_1/target_file_1 ../output/sample_output_1/target_file_1
diff ../input/sample_input_1/target_file_2 ../output/sample_output_1/target_file_2
diff ../input/sample_input_1/target_file_3 ../output/sample_output_1/target_file_3
diff ../input/sample_input_1/target_file_4 ../output/sample_output_1/target_file_4
diff ../input/sample_input_1/target_file_5 ../output/sample_output_1/target_file_5
diff ../input/sample_input_1/target_file_6 ../output/sample_output_1/target_file_6
diff ../input/sample_input_1/target_file_7 ../output/sample_output_1/target_file_7
diff ../input/sample_input_1/target_file_8 ../output/sample_output_1/target_file_8
diff ../input/sample_input_1/target_file_9 ../output/sample_output_1/target_file_9
diff ../input/sample_input_1/target_file_10 ../output/sample_output_1/target_file_10

echo Receiving sample 2 with file I/O
./slave 1 ../output/sample_output_2/target_file fcntl 127.0.0.1 2>&1 | tee ../output/sample_output_2/fcntl_result.txt
echo Diffing input and output
diff ../input/sample_input_2/target_file ../output/sample_output_2/target_file


echo Receiving sample 3 with file I/O
./slave 1 ../output/sample_output_3/newdata.txt fcntl 127.0.0.1 2>&1 | tee ../output/sample_output_3/fcntl_result.txt
echo Diffing input and output
diff ../input/sample_input_3/newdata.txt ../output/sample_output_3/newdata.txt

echo Receiving sample 1 with mmap I/O
./slave 10 ../output/sample_output_1/target_file_1 ../output/sample_output_1/target_file_2 ../output/sample_output_1/target_file_3 ../output/sample_output_1/target_file_4 ../output/sample_output_1/target_file_5 ../output/sample_output_1/target_file_6 ../output/sample_output_1/target_file_7 ../output/sample_output_1/target_file_8 ../output/sample_output_1/target_file_9 ../output/sample_output_1/target_file_10 mmap 127.0.0.1  2>&1 | tee ../output/sample_output_1/mmap_result.txt
echo Diffing input and output
diff ../input/sample_input_1/target_file_1 ../output/sample_output_1/target_file_1
diff ../input/sample_input_1/target_file_2 ../output/sample_output_1/target_file_2
diff ../input/sample_input_1/target_file_3 ../output/sample_output_1/target_file_3
diff ../input/sample_input_1/target_file_4 ../output/sample_output_1/target_file_4
diff ../input/sample_input_1/target_file_5 ../output/sample_output_1/target_file_5
diff ../input/sample_input_1/target_file_6 ../output/sample_output_1/target_file_6
diff ../input/sample_input_1/target_file_7 ../output/sample_output_1/target_file_7
diff ../input/sample_input_1/target_file_8 ../output/sample_output_1/target_file_8
diff ../input/sample_input_1/target_file_9 ../output/sample_output_1/target_file_9
diff ../input/sample_input_1/target_file_10 ../output/sample_output_1/target_file_10

echo Receiving sample 2 with mmap I/O
./slave 1 ../output/sample_output_2/target_file mmap 127.0.0.1 2>&1 | tee ../output/sample_output_2/mmap_result.txt
echo Diffing input and output
diff ../input/sample_input_2/target_file ../output/sample_output_2/target_file

echo Receiving sample 3 with mmap I/O
./slave 1 ../output/sample_output_3/newdata.txt mmap 127.0.0.1 2>&1 | tee ../output/sample_output_3/mmap_result.txt
echo Diffing input and output
diff ../input/sample_input_3/newdata.txt ../output/sample_output_3/newdata.txt