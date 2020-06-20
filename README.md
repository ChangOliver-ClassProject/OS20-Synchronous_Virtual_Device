# OS20-Synchronous-Virtual-Device

## Structure
master_device : the device moudule for master server.  
slave_device  : the device moudule for slave client.  
ksocket: the device moudule including the funtions used for kernel socket.  
user_program : the user program "master" and "slave".  

## Usage
+ For general usage:  
  1.change to super user.  
  2.execute "./compile.sh" to compile codes and install modules.   
  3.follow the input instrutions in the spec, i.e. 
    ```
    ./master 1 file1_in mmap   
    ./slave 1 file1_out fcntl 127.0.0.1 
    ```
    
+ For reproducing our result:  
  1.change to super user.  
  2.simply execute "./run_master.sh" to compile and start the master program.  
  3.exceute "./run_slave.sh" to start the slave program.  
