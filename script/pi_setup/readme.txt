Instructions on how to setup a raspberry pi.
Script has been tested on Ubuntu 12.10.

How to modify Raspbian image (script)
-------------------------------------

1.  Download a raspbian image file (http://www.raspberrypi.org/downloads)

2.  Make sure this folder is your working directory

3.  Decide the url that your pi should connect to.
    Remember to put /client at the end!

4.  Run the setup script with
    sudo sh pi_setup.sh <url> <image path>

5.  If no errors occurred, image is ready

How to modify Raspbian image (manual)
-------------------------------------

1.  Mount raspbian image (http://www.raspberrypi.org/downloads) with command
    sudo mount -o loop,offset=$((122880*512)) <image path> <where image should be mounted>

2.  Copy local_page.html and jquery.min.js to pi's home folder.

3.  In local_page.html, replace REPLACE_WITH_URL with the server url.
    Remember to put /client at the end!

4.  Create a folder named midori_config in pi's home folder.
    Create a file "config" in that folder that contains:

    [settings]
    enable-universal-access-from-file-uris=true

5.  In pi's /etc/lightdm/lightdm.conf, add a line after [SeatDefaults]:

    xserver-command=X -s 0 -dpms

6.  Copy auto.desktop to /etc/xdg/autostart/

7.  Unmount and write to sd-card.

About modifying pi setup
------------------------

- If the server url needs to be changed after pi has already been set up, this can
be achieved easily by editing local_page.html in /home/pi/. Replace the url variables
old contents with the new url.

- The options of midori can be changed by editing auto.desktop's line that currently reads
Exec=midori -a file:///home/pi/local_page.html -e Fullscreen -c /home/pi/midori_config/

Troubleshooting
---------------

mount: you must specify the filesystem type

  Type "file -s <image path>" into terminal. Output should look like:

  x86 boot sector;
  partition 1: ID=0xc, starthead 130, startsector 8192, 114688 sectors;
  partition 2: ID=0x83, starthead 165, startsector 122880, 3665920 sectors, code offset 0xb8

  Copy the value of partition 2 start sector, in this case 122880. Replace
  the start_sector variable in pi_setup.sh with the copied value.
