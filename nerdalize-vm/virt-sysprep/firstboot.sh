#!/bin/bash
sudo rm -rf /etc/ssh/ssh_host_*
sudo dpkg-reconfigure openssh-server # does 'sudo ssh-keygen -A'

# set hostname in /etc/hosts
# 'virt-sysprep --hostname XXX' should do this, but libguestfs < 1.25.35 doesn't
#sed -i 's/127.0.1.1.*/127.0.1.1\t'"$(hostname)"'/g' /etc/hosts

