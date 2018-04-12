#!/bin/bash
#
#
#
#

##########################################################################
#
#install stream video and ffmpeg
#
##########################################################################


echo "step 1: install some dependencies......"
sudo apt-get update
sudo apt-get install automake vim build-essential git-core checkinstall texi2html libfaac-dev libtool -y
sudo apt-get install libopencore-amrnb-dev libopencore-amrwb-dev libsdl1.2-dev libtheora-dev -y
sudo apt-get install libvorbis-dev libx11-dev libxfixes-dev zlib1g-dev libgtk2.0-dev libavcodec-dev libavformat-dev  libtiff5-dev cmake libswscale-dev libjasper-dev -y


echo "step2: install h264 coding lib......"
cd x264
sudo ./configure --enable-shared --disable-asm
sudo make
sudo make install

echo "step3: install FFMPEG"
cd ../ffmpeg-3.0.9/
sudo ./configure --enable-shared --enable-pthreads --enable-gpl  --enable-avresample --enable-libx264 --enable-libtheora  --disable-yasm
sudo make
sudo make install


echo "step4: edit ffmpeg config"
echo "/usr/local/lib" >> /etc/ld.so.conf
sudo ldconfig

echo "step5: install Nginx dependencies....."
cd ../pcre-8.40/
sudo ./configure
sudo make
sudo make install

cd ../zlib-1.2.11/
sudo ./configure
sudo make
sudo make install

cd ../openssl-1.1.0/
sudo ./config
sudo make
sudo make install

echo "step6: install Nginx"
cd ../nginx-1.12.0/
sudo ./configure --prefix=/usr/local/nginx --with-pcre=../pcre-8.40 --with-zlib=../zlib-1.2.11 --with-openssl=../openssl-1.1.0  --with-http_ssl_module --add-module=../nginx-rtmp-module

sudo make
sudo make install

sudo echo "rtmp {
    server {
        listen 1935;
		application rgb{
			live on;
			allow all;
		}
		application depth{
			live on;
			allow all;
		}
    }
}" >> /usr/local/nginx/conf/nginx.conf


##########################################################################
#
#install ROS and xbot drivers
#
##########################################################################
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
sudo apt-get install ros-kinetic-dwa-local-planner -y
sudo apt-get install ros-kinetic-robot-upstart -y
sudo apt-get install ros-kinetic-ecl -y
sudo apt-get install ros-kinetic-yocs-controllers -y
sudo apt-get install ros-kinetic-rosbridge-server -y

./setupCatkinWorkspace.sh


#六、安装xbot驱动程序以及ROS驱动包
git clone https://github.com/DroidAITech/xbot.git ~/catkin_ws/src/xbot/
git clone https://github.com/DroidAITech/rplidar_ros.git ~/catkin_ws/src/rplidar_ros/
sudo cp ~/catkin_ws/src/rplidar_ros/scripts/rplidar.rules /etc/udev/rules.d/57-rplidar.rules
sudo service udev restart
source ~/.bashrc

#rosrun robot_upstart install xbot_bringup/launch/xbot_websocket.launch
#sudo systemctl daemon-reload
#sudo systemctl start xbot
#


sudo echo "source /opt/ros/kinetic/setup.bash" >> ~/.bashrc
sudo echo "source ~/catkin_ws/devel/setup.bash" >> ~/.bashrc
sudo echo "export ROS_MASTER_URI=http://192.168.8.101:11311" >> ~/.bashrc
sudo echo "export ROS_HOSTNAME=172.16.8.101" >> ~/.bashrc

source ~/.bashrc
# catkin_make
cd ~/catkin_ws
catkin_make




