#!/bin/bash
(( EUID )) && echo You need to be root. && exit 1
set -ex

ARMADA_DIR=~/apps/armada
if [ -d $ARMADA_DIR ]; then
  rm -rf $ARMADA_DIR
fi

cd ~/apps
git clone http://github.com/sktelecom-oslab/armada.git && cd armada
OS_DISTRO=$(cat /etc/os-release | grep "PRETTY_NAME" | sed 's/PRETTY_NAME=//g' | sed 's/["]//g' | awk '{print $1}')
if [ $OS_DISTRO == Red ]; then
    yum -y install https://rhel7.iuscommunity.org/ius-release.rpm
    yum -y install python36u python36u-devel
    yum install -y python36u-pip
    pip3.6 install .
elif [ $OS_DISTRO == CentOS ]; then
    yum -y install https://centos7.iuscommunity.org/ius-release.rpm
    yum -y install python36u python36u-devel
    yum install -y python36u-pip
    pip3.6 install .
elif [ $OS_DISTRO == Ubuntu ]; then
    apt-get install -y python3-pip
    pip3 install --upgrade pip
    pip3 install .
else
    echo "This Linux Distribution is NOT supported"
fi
