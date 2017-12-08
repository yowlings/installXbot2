sudo apt-get update
sudo apt-get install firefox -y
sudo apt-get install git -y
sudo cp -rf boot/ /
sudo cp -rf modules/ /lib/
sudo cp 58-xbot.rules /etc/udev/rules.d/
sudo service udev restart
git clone https://github.com/jetsonhacks/installROSTX2.git
cd installROSTX2
./updateRepositories.sh
./installROS.sh
./setupCatkinWorkspace.sh
echo "source ~/catkin_ws/devel/setup.bash" >> ~/.bashrc
echo "export ROS_MASTER_URI=http://192.168.8.101:11311" >> ~/.bashrc
echo "export ROS_HOSTNAME=192.168.8.101" >> ~/.bashrc
cd ~/catkin_ws/src/
git clone https://github.com/DroidAITech/xbot2
git clone https://github.com/DroidAITech/xbot2_description
sudo apt-get install ros-kinect-controller-mannager -y
sudo apt-get install ros-kinect-gazebo-ros -y
sudo apt-get install ros-kinect-xacro -y
sudo apt-get install ros-kinect-rqt-plot -y
sudo apt-get install ros-kinect-rviz -y
cd ~/catkin_ws
catkin_make
sudo reboot