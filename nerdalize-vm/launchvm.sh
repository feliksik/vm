#!/bin/bash

if [[ $# -lt 3 ]]; then
  echo "usage: $0 hostip vmname tunnelport" 2>/dev/stdout
  exit 1
fi

OLDDIR=$(pwd)

HOSTIP=$1
VMNAME=$2
PORT=$3
VMDIR=~/live/vms/$VMNAME


die(){
	echo "Error: $1"
	exit 1
}
if [ -e "$VMDIR" ]; then
  die "Error: $VMDIR already exists"
fi

mkdir -p $VMDIR/connections || die "Cannot create dir $VMDIR"

# create docker compose config file
#
cat <<EOF >$VMDIR/config.yml
image: nerdalize-vm-c.img
vmname: $VMNAME
password: $(openssl rand -base64 20 | tr -d '=' | head -c12)
vmbase_version: latest
ntunclient_version: latest
memory: 8192
cores: 8
port: $PORT
EOF

j2 compose.j2 $VMDIR/config.yml >$VMDIR/docker-compose.yml

j2 connections/ssh.conf.j2 $VMDIR/config.yml >$VMDIR/connections/ssh.conf


# create virt-sysprep file and firstboot
#
mkdir -p $VMDIR/virt-sysprep
j2 virt-sysprep/sysprep.sh.j2 $VMDIR/config.yml >$VMDIR/virt-sysprep/sysprep.sh
chmod +x $VMDIR/virt-sysprep/sysprep.sh
cp virt-sysprep/firstboot.sh $VMDIR/virt-sysprep/firstboot.sh


cd $VMDIR

docker-compose up -d

cd $OLDDIR
