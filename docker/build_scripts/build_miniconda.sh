#!/bin/bash
# Script called from Dockerfile to install build tools

# Stop at any error, show all commands
set -ex

# install build tools
conda install --yes -c pelson/channel/development obvious-ci
obvci_install_conda_build_tools.py
conda clean -t -p

