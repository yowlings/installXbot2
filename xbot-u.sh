#!/bin/bash

source ~/.bashrc
roslaunch xbot_bringup xbot_rplidar_websocket.launch & ffmpeg -f v4l2  -i /dev/video2 -r 25 -b:v 400k -vcodec h264 -preset superfast -tune zerolatency -an  -f flv rtmp://localhost/rgb
