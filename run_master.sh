#!/bin/bash

./compile.sh
cd user_program
./master 10 ../sample_input/sample_input_1/target_file_1 ../sample_input/sample_input_1/target_file_2 ../sample_input/sample_input_1/target_file_3 ../sample_input/sample_input_1/target_file_4 ../sample_input/sample_input_1/target_file_5 ../sample_input/sample_input_1/target_file_6 ../sample_input/sample_input_1/target_file_7 ../sample_input/sample_input_1/target_file_8 ../sample_input/sample_input_1/target_file_9 ../sample_input/sample_input_1/target_file_10 fcntl
./master 1 ../sample_input/sample_input_2/target_file fcntl
./master 1 ../sample_input/sample_input_3/newdata.txt fcntl
./clean.sh
