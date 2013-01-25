How to modify Raspbian image
----------------------------

Script has been tested on Ubuntu 12.10

1. Download a raspbian image file (http://www.raspberrypi.org/downloads)

2. Make sure this folder is your working directory

3. Decide the url that your pi should connect to

4. Run the setup script with
  
  sudo sh pi_setup.sh <url> <image path>

5. If no errors occurred, image is ready


Troubleshooting
----------------------------

mount: you must specify the filesystem type

  Type "file -s <image path>" into terminal. Output should look like:

  x86 boot sector;
  partition 1: ID=0xc, starthead 130, startsector 8192, 114688 sectors;
  partition 2: ID=0x83, starthead 165, startsector 122880, 3665920 sectors, code offset 0xb8

  Copy the value of partition 2 start sector, in this case 122880. Replace
  the start_sector variable in pi_setup.sh with the copied value. 

