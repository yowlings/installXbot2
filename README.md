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

