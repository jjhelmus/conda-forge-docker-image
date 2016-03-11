#!/bin/bash
# Script called from Dockerfile to install Miniconda and build tools

# Stop at any error, show all commands
set -ex

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

