#!/bin/bash

if [ "$EUID" -ne 0 ]
  then echo "Please run as root"
  exit
fi

set -e
set -x

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# Install drive through DKMS
chmod u+x ${DIR}/scripts/install.sh
${DIR}/scripts/install.sh

# Load driver
sudo modprobe -a hid_magicmouse
