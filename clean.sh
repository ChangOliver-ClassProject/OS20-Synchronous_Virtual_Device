cd ./master_device
make clean
rmmod master_device.ko
cd ../slave_device
make clean
rmmod slave_device.ko
cd ../user_program
make clean
cd ../ksocket
make clean
rmmod ksocket.ko

cd ../output/sample_output_1
rm -f *
cd ../sample_output_2
rm -f *
cd ../sample_output_3
rm -f *


