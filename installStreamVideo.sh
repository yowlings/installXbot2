echo "step 1: install some dependencies"
sudo apt-get update
sudo apt-get install build-essential git-core checkinstall texi2html libfaac-dev libtool
sudo apt-get install libopencore-amrnb-dev libopencore-amrwb-dev libsdl1.2-dev libtheora-dev
sudo apt-get install libvorbis-dev libx11-dev libxfixes-dev zlib1g-dev libgtk2.0-dev libavcodec-dev libavformat-dev  libtiff4-dev cmake libswscale-dev libjasper-dev

echo "step2: install OpenCV"
mkdir software
cd software
wget https://github.com/opencv/opencv/archive/3.2.0.zip
sudo unzip 3.2.0.zip 
cd opencv-3.2.0
cmake .
make
sudo make install


echo "step3: install FFMPEG and h264 coding lib"
sudo apt-get install libx264-dev
cd ..
git clone git://git.videolan.org/x264
cd x264
./configure --enable-shared   
make	
sudo make install

cd ..
wget http://ffmpeg.org/releases/ffmpeg-3.0.9.tar.bz2
sudo tar jxvf ffmpeg-3.0.9.tar.bz2
cd ffmpeg-3.0.9/
sudo ./configure --enable-shared --enable-pthreads --enable-gpl  --enable-avresample --enable-libx264 --enable-libtheora  --disable-yasm

make
sudo make install

echo "step4: edit ffmpeg config"
echo "/usr/local/lib" >> /etc/ld.so.conf
sudo ldconfig

echo "step5: install Nginx dependencies....."
cd ..
mkdir nginx-dependence
cd nginx-dependence
sudo wget ftp://ftp.csx.cam.ac.uk/pub/software/programming/pcre/pcre-8.40.tar.gz
sudo tar -zxvf pcre-8.40.tar.gz
cd pcre-8.40/
sudo ./configure
sudo make
sudo make install
cd ..

sudo wget http://zlib.net/zlib-1.2.11.tar.gz
sudo tar -zxvf zlib-1.2.11.tar.gz
cd zlib-1.2.11/
sudo ./configure
sudo make
sudo make install
cd ..

sudo wget https://www.openssl.org/source/old/1.1.0/openssl-1.1.0.tar.gz
sudo tar -axvf openssl-1.1.0.tar.gz
cd openssl-1.1.0/
sudo ./config
sudo make
sudo make install
cd ..
git clone https://github.com/arut/nginx-rtmp-module.git

echo "step6: install Nginx"
cd ..

sudo wget http://nginx.org/download/nginx-1.12.0.tar.gz
sudo tar -zxvf nginx-1.12.0.tar.gz
cd nginx-1.12.0/

sudo ./configure --prefix=/usr/local/nginx --with-pcre=../nginx-dependence/pcre-8.40 --with-zlib=../nginx-dependence/zlib-1.2.11 --with-openssl=../nginx-dependence/openssl-1.1.0  --with-http_ssl_module --add-module=../nginx-dependence/nginx-rtmp-module

sudo make
sudo make install






