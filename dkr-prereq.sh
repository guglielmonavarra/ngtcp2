# !/bin/bash.sh
export DEBIAN_FRONTEND=noninteractive
export CXX=g++
export CC=gcc

ln -fs /usr/share/zoneinfo?america/New_York /etc/localtime
apt-get install -y tzdata
dkpg-reconfigure
apt-get -y update
apt-get -y -q install build-essential
apt-get -y -q install git
apt-get -y -q install clang-12
apt-get -y -q install cmake
apt-get -y -q install libtool
apt-get -y -q install libssl-dev
apt-get -y -q install pkg-config
apt-get -y -q install libev-dev libjemalloc-dev
apt-get -y -q install libjemalloc-dev
apt-get -y -q install libjemalloc2 
apt-get -y -q install libev4
apt-get -y -q install ca-certificates
apt-get -y -q install mime-support
apt-get -y -q install llvm-12 
apt-get -y -q install libasan5
apt-get -y -q install libubsan1



git clone --depth 1 -b OpenSSL_1_1_1t+quic https://github.com/quictls/openssl
cd openssl
./config --openssldir=/etc/ssl 
make -j$(nproc) 
make install_sw 
cd .. 
rm -rf openssl 
git clone --depth 1 https://github.com/ngtcp2/nghttp3
cd nghttp3 
autoreconf -i
./configure --enable-lib-only CC=clang-12 CXX=clang++-12 LDFLAGS="-fsanitize=address,undefined -fno-sanitize-recover=undefined" CPPFLAGS="-fsanitize=address,undefined -fno-sanitize-recover=undefined -g3"
make -j$(nproc)
make install 
cd .. 
rm -rf nghttp3

git clone --depth 1 https://github.com/ngtcp2/ngtcp2
cd ngtcp2
autoreconf -i
./configure CC=clang-12 CXX=clang++-12 LDFLAGS="-fsanitize=address,undefined -fno-sanitize-recover=undefined" CPPFLAGS="-fsanitize=address,undefined -fno-sanitize-recover=undefined -g3"
make -j$(nproc)
make install 
cp examples/server examples/client examples/h09server examples/h09client /usr/local/bin 
cd .. 
rm -rf ngtcp2 
rm -rf /usr/local/lib/libssl.so /usr/local/lib/libcrypto.so /usr/local/lib/libssl.a /usr/local/lib/libcrypto.a /usr/local/lib/pkgconfig/*ssl.pc /usr/local/include/openssl/*
apt-get -y purge git g++ clang-12 make binutils autoconf automake autotools-dev libtool pkg-config libev-dev libjemalloc-dev
apt-get -y autoremove --purge 
rm -rf /var/log/*

