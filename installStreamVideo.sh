echo "step 1: install some dependencies......"
sudo apt-get update
sudo apt-get install build-essential git-core checkinstall texi2html libfaac-dev libtool
sudo apt-get install libopencore-amrnb-dev libopencore-amrwb-dev libsdl1.2-dev libtheora-dev
sudo apt-get install libvorbis-dev libx11-dev libxfixes-dev zlib1g-dev libgtk2.0-dev libavcodec-dev libavformat-dev  libtiff5-dev cmake libswscale-dev libjasper-dev


echo "step2: install h264 coding lib......"
cd x264
./configure --enable-shared --disable-asm
make
sudo make install

echo "step3: install FFMPEG"
cd ../ffmpeg-3.0.9/
sudo ./configure --enable-shared --enable-pthreads --enable-gpl  --enable-avresample --enable-libx264 --enable-libtheora  --disable-yasm
make
sudo make install


echo "step4: edit ffmpeg config"
echo "/usr/local/lib" >> /etc/ld.so.conf
sudo ldconfig

echo "step5: install Nginx dependencies....."
cd ../pcre-8.40/
./configure
make
sudo make install

cd ../zlib-1.2.11/
./configure
make
sudo make install

cd ../openssl-1.1.0/
./config
make
sudo make install

echo "step6: install Nginx"
cd ../nginx-1.12.0/
./configure --prefix=/usr/local/nginx --with-pcre=../pcre-8.40 --with-zlib=../zlib-1.2.11 --with-openssl=../openssl-1.1.0  --with-http_ssl_module --add-module=../nginx-rtmp-module

make
sudo make install






