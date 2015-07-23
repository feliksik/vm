#!/bin/sh

# /etc/nerdalize/firstboot.sh
# file for initializing client vm


sudo rm -rf /etc/ssh/ssh_host_*
sudo dpkg-reconfigure openssh-server # does 'sudo ssh-keygen -A'

# set hostname in /etc/hosts
# 'virt-sysprep --hostname XXX' should do this, but libguestfs < 1.25.35 doesn't
sed -i 's/127.0.1.1.*/127.0.1.1\t'"$(hostname)"'/g' /etc/hosts


deluser --remove-home nerdalize
deluser --group nerdalize


echo "client ALL=NOPASSWD: ALL" >>/etc/sudoers
locale-gen en_US en_US.UTF-8 nl_NL.UTF-8
dpkg-reconfigure locales



