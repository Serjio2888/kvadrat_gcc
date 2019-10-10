sudo add-apt-repository -y ppa:ubuntu-toolchain-r/test
sudo apt-get update -qq

sudo apt-get install -qq gcc-5
sudo update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-5 90

CMAKE_VERSION=3.10
CMAKE_VERSION_DIR=v3.10

CMAKE_OS=Linux-x86_64
CMAKE_TAR=cmake-$CMAKE_VERSION-$CMAKE_OS.tar.gz
CMAKE_URL=http://www.cmake.org/files/$CMAKE_VERSION_DIR/$CMAKE_TAR
CMAKE_DIR=$(pwd)/cmake-$CMAKE_VERSION

wget --quiet $CMAKE_URL
mkdir -p $CMAKE_DIR
tar --strip-components=1 -xzf $CMAKE_TAR -C $CMAKE_DIR
export PATH=$CMAKE_DIR/bin:$PATH

if [ "$TARGET_CPU" == "x86" ]; then
    sudo dpkg --add-architecture i386
    sudo apt-get -qq update

    # устанавливаем 32-битные версии необходимых проекту библиотек
    sudo apt-get install -y liblua5.2-dev:i386
    sudo apt-get install -y libusb-1.0:i386
    # ...

    # g++-multilib ставим в самом конце, после i386-пакетов!
    sudo apt-get install -y g++-5-multilib
fi
