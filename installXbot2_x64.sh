#!/bin/bash
echo "开始安装基础工具软件......"
sudo apt-get update
sudo apt-get install git -y
sudo apt-get install ssh -y
echo "开始对机器人端口进行映射......"
sudo cp 58-xbot.rules /etc/udev/rules.d/
sudo service udev restart
echo "加入ROS安装库......"
sudo sh -c 'echo "deb http://packages.ros.org/ros/ubuntu $(lsb_release -sc) main" > /etc/apt/sources.list.d/ros-latest.list'
# Setup keys
sudo apt-key adv --keyserver hkp://ha.pool.sks-keyservers.net:80 --recv-key 421C365BD9FF1F717815A3895523BAEEB01FA116
# Installation
sudo apt-get update
sudo apt-get install ros-kinetic-desktop-full -y
# Add Individual Packagejis here
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
sudo apt-get install ros-kinetic-controller-manager -y
sudo apt-get install ros-kinetic-move-base -y
sudo apt-get install ros-kinetic-move-base-msgs -y
sudo apt-get install ros-kinetic-hector-slam -y
sudo apt-get install ros-kinetic-gmapping -y
sduo apt-get install ros-kinetic-dwa-local-planner -y
sudo apt-get install ros-kinetic-robot-upstart -y
sudo apt-get install ros-kinetic-ecl -y


./setupCatkinWorkspace.sh


#六、安装xbot驱动程序以及ROS驱动包
cd 
git clone https://github.com/DroidAITech/xbot2.git ~/catkin_ws/src/xbot2/
git clone https://github.com/DroidAITech/rplidar_ros.git ~/catkin_ws/src/rplidar_ros/
sudo cp ~/catkin_ws/src/rplidar_ros/scripts/rplidar.rules /etc/udev/rules.d/57-rplidar.rules
sudo service udev restart
source ~/.bashrc
cd ~/catkin_ws
catkin_make
rosrun robot_upstart install xbot_bringup/launch/xbot_websocket.launch
sudo systemctl daemon-reload
sudo systemctl start xbot




