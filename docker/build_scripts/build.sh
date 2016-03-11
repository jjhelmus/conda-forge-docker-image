#!/bin/bash
# Top-level build script called from Dockerfile

# Stop at any error, show all commands
set -ex

# Install only the x86_64 packages
echo "multilib_policy=best" >> /etc/yum.conf

# Libraries that are allowed as part of the manylinux1 profile
MANYLINUX1_DEPS="glibc-devel libstdc++-devel glib2-devel libX11-devel libXext-devel libXrender-devel  mesa-libGL-devel libICE-devel libSM-devel ncurses-devel"

# EPEL support
yum -y install wget curl
curl -sLO https://dl.fedoraproject.org/pub/epel/5/x86_64/epel-release-5-4.noarch.rpm

# Dev toolset (for LLVM and other projects requiring C++11 support)
curl -sL http://people.centos.org/tru/devtools-2/devtools-2.repo > /etc/yum.repos.d/devtools-2.repo
rpm -Uvh --replacepkgs epel-release-5*.rpm
rm -f epel-release-5*.rpm

# Development tools and libraries
yum -y install bzip2 make git patch unzip bison yasm diffutils \
    autoconf automake which file \
    devtoolset-2-binutils devtoolset-2-gcc \
    devtoolset-2-gcc-c++ devtoolset-2-gcc-gfortran

# Install patchelf
curl -sLO http://nixos.org/releases/patchelf/patchelf-0.8/patchelf-0.8.tar.gz
tar -xzf patchelf-0.8.tar.gz
(cd patchelf-0.8 && ./configure && make && make install)
rm -rf patchelf-0.8.tar.gz patchelf-0.8

# Clean up development headers and other unnecessary stuff for
# final image
yum -y erase wireless-tools gtk2 libX11 hicolor-icon-theme \
    avahi freetype bitstream-vera-fonts > /dev/null 2>&1

yum -y install ${MANYLINUX1_DEPS}
yum -y clean all > /dev/null 2>&1

# Install Miniconda
wget https://repo.continuum.io/miniconda/Miniconda3-latest-Linux-x86_64.sh \
    --no-verbose
bash Miniconda3-latest-Linux-x86_64.sh -b -p /opt/conda
rm Miniconda*.sh

# configure conda
export PATH=/opt/conda/bin:$PATH
conda config --set show_channel_urls True
conda update --all --yes

# install build tools
conda install --yes -c pelson/channel/development obvious-ci
obvci_install_conda_build_tools.py
conda clean -t -p

# print out all installed packages, and then again by size
yum list installed
rpm -qa --queryformat '%10{size} - %-25{name} \t %{version}\n' | sort -n
