# 相关依赖包、工具
yum install epel-release -y
yum install git -y
yum install gcc gettext autoconf libtool automake make pcre-devel asciidoc xmlto udns-devel c-ares-devel libev-devel libsodium-devel mbedtls-devel -y
yum install python2 -y

# 获取 shadowsocks-libev
git clone https://github.com/shadowsocks/shadowsocks-libev.git
cd shadowsocks-libev
git submodule update --init --recursive

# 安装 Libsodium
export LIBSODIUM_VER=1.0.18
wget https://download.libsodium.org/libsodium/releases/libsodium-$LIBSODIUM_VER.tar.gz
tar xvf libsodium-$LIBSODIUM_VER.tar.gz
pushd libsodium-$LIBSODIUM_VER
./configure --prefix=/usr && make
sudo make install
popd
sudo ldconfig

# 安装 MbedTLS
export MBEDTLS_VER=2.16.6
wget https://tls.mbed.org/download/mbedtls-$MBEDTLS_VER-gpl.tgz
tar xvf mbedtls-$MBEDTLS_VER-gpl.tgz
pushd mbedtls-$MBEDTLS_VER
make SHARED=1 CFLAGS=-fPIC
sudo make DESTDIR=/usr install
popd
sudo ldconfig

# 编译 shadowsocks-libev
./autogen.sh && ./configure && make
sudo make install

# 创建配置
sudo mkdir /etc/shadowsocks-libev
pushd /etc/shadowsocks-libev
