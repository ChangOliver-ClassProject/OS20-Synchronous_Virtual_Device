#!/bin/bash

cd user_program
./slave 10 ../sample_output/sample_output_1/target_file_1 ../sample_output/sample_output_1/target_file_2 ../sample_output/sample_output_1/target_file_3 ../sample_output/sample_output_1/target_file_4 ../sample_output/sample_output_1/target_file_5 ../sample_output/sample_output_1/target_file_6 ../sample_output/sample_output_1/target_file_7 ../sample_output/sample_output_1/target_file_8 ../sample_output/sample_output_1/target_file_9 ../sample_output/sample_output_1/target_file_10 fcntl
./slave 1 ../sample_output/sample_output_2/target_file fcntl
./slave 1 ../sample_output/sample_output_3/newdata.txt fcntl
