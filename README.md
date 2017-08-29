# installXbot2
## choose your platform to install ROS
### case TX2
installROSTX2
Install Robot Operating System (ROS) on NVIDIA Jetson TX2

These scripts will install Robot Operating System (ROS) on the NVIDIA Jetson TX2 development kit.

Tested on L4T 27.1

The script is based on the Ubuntu ARM install of ROS Kinetic: http://wiki.ros.org/kinetic/Installation/UbuntuARM

Maintainer of ARM builds for ROS is http://answers.ros.org/users/1034/ahendrix/

<strong>updateRepositories.sh</strong>
This is an optional step. Adds the repositories universe, multiverse, and restricted and then apt-get update. These repositories are in the standard 27.1 install, so probably not needed.

<strong>installROS_TX2.sh</strong>
Adds the ROS sources list, sets the keys and then loads ros-kinetic-ros-base. Edit this file to add other ROS packages for your installation. After loading, rosdep is initialized.

<strong>setupCatkinWorkspace.sh</strong>
Usage:

$ ./setupCatkinWorkspace.sh [optionalWorkspaceName]

where optionalWorkspaceName is the name of the workspace to be used. The default workspace name is catkin_ws. This script also sets up some ROS environment variables. Refer to the script for details.
### case x86
change the command <strong>installROS_TX2.sh</strong> to <strong>installROS_x86.sh</strong> in case TX2。

## other support lib for TX2
### libusb
As sick_tim ROS package requires the libusb libs,  but there only libusb-1.0 installed in TX2, so we have to edit the CMakeLists.txt in sick_tim package to change the second <strong>libusb</strong> in line 12 to <strong>libusb-1.0</strong>。

### plugdev
You have to add your username to the group plugdev for TX2 read your sick divice. After copy the file 81-sick-tim3xx.rules to /etc/udev/rules.d/, add user to plugdev by command:
<strong>sudo passwd -a username plugdev</strong>
replace usermane to your own username ,for example, for me it is ubuntu.

### TX2 has no ttyUSB0 problem
clone https://github.com/jetsonhacks/buildJetsonTX2Kernel.git and check to  vL4T27.1 branch, then operate as the README tells;

In the kernel making process, there will be a new config window for you to check which item to be marked, mark <strong>devices support/usb convert support/FTDI devices</strong>

Once you have build your new kernel, you do not have to build for every new TX2, just copy the file /boot/ and /lib/modules/ to replace the files in new TX2.

