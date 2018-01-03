echo "step 1: install some dependencies......"
sudo apt-get update
sudo apt-get install build-essential git-core checkinstall texi2html libfaac-dev libtool -y
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






