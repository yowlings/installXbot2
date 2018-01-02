#!/bin/bash
#二、安装基础工具软件
sudo apt-get update
sudo apt-get install git -y

#四、对机器人端口进行映射
sudo cp 58-xbot.rules /etc/udev/rules.d/
sudo service udev restart

sudo sh -c 'echo "deb http://packages.ros.org/ros/ubuntu $(lsb_release -sc) main" > /etc/apt/sources.list.d/ros-latest.list'
# Setup keys
sudo apt-key adv --keyserver hkp://ha.pool.sks-keyservers.net:80 --recv-key 421C365BD9FF1F717815A3895523BAEEB01FA116
# Installation
sudo apt-get update
sudo apt-get install ros-kinetic-ros-desktop-full -y
# Add Individual Packages here
# You can install a specific ROS package (replace underscores with dashes of the package name):
# sudo apt-get install ros-kinetic-PACKAGE
# e.g.
# sudo apt-get install ros-kinetic-navigation
#
# To find available packages:
# apt-cache search ros-kinetic
# 
# Initialize rosdep
sudo apt-get install python-rosdep -y
# Certificates are messed up
sudo c_rehash /etc/ssl/certs
# Initialize rosdep
sudo rosdep init
# To find available packages, use:
rosdep update
# Environment Setup
echo "source /opt/ros/kinetic/setup.bash" >> ~/.bashrc
source ~/.bashrc
# Install rosinstall
# 七、安装xbot ROS驱动包依赖的软件
sudo apt-get install python-rosinstall -y
sudo apt-get install ros-kinetic-yocs-cmd-vel-mux -y
sudo apt-get install ros-kinetic-controller-mannager
sudo apt-get install ros-kinetic-move-base
sudo apt-get install ros-kinetic-move-base-msgs
sudo apt-get install ros-kinetic-hector-slam
sudo apt-get install ros-kinetic-gmapping
sudo apt-get install ros-kinetic-robot-upstart

./setupCatkinWorkspace.sh


#六、安装xbot驱动程序以及ROS驱动包
cd 
git clone https://github.com/DroidAITech/xbot2 ~/catkin_ws/src/xbot2/
git clone https://github.com/DroidAITech/xbot2_description ~/catkin_ws/src/xbot2_description/
git clone https://github.com/robopeak/rplidar_ros.git ~/catkin_ws/src/rplidar_ros/
source ~/.bashrc
cd ~/catkin_ws
catkin_make
rosrun robot_upstart install xbot_bringup/launch/xbot_websocket.launch
sudo systemctl daemon-reload
sudo systemctl start xbot




