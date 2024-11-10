# Linux Apple Magic Trackpad 2 USB-C Driver

 This driver adds support for the 2024 USB-C version of the Magic Trackpad 2. Upstream support in the kernel can be found [here](https://patchwork.kernel.org/project/linux-input/patch/20241110002816.6064-1-callahankovacs@gmail.com/).

This is not needed for older Apple Magic devices, because they are supported with kernel version 5.15 and newer.

I have not tested or added support for the 2024 USB-C Magic Keyboard or Magic Mouse, because I do not own them. PRs are welcome or you can send me some hardware!

## Install

### DKMS

To install the driver directly with dkms:

```bash
sudo apt-get install dkms
git clone https://github.com/mr-cal/Linux-Magic-Trackpad-2-USB-C-Driver.git
cd Linux-Magic-Trackpad-2-USB-C-Driver
chmod u+x install.sh
sudo ./install.sh
```

### Github release

To install driver on Debian, Ubuntu, and derivatives as a deb package, download the latest release [here](https://github.com/mr-cal/Linux-Magic-Trackpad-2-USB-C-Driver/releases) and install it with:

```bash
wget https://github.com/mr-cal/Linux-Magic-Trackpad-2-USB-C-Driver/releases/download/latest/magicmouse-hid_2.1.0-0.deb
sudo dpkg -i magicmouse-hid_2.1.0-0.deb
```

### Build a deb

To build and install the deb yourself:

```bash
./build-deb.sh
sudo dpkg -i magicmouse-hid_2.1.0-0.deb
```

## Reload

The driver can be reloaded with:

```bash
sudo rmmod hid_magicmouse
sudo modprobe hid_magicmouse
```

## Uninstall

### DKMS

```bash
sudo ./remove.sh
```

### Deb package

```bash
sudo dpkg -r magicmouse-hid
```

## Wayland and X11

Magic Trackpads work significantly better out of the box when using Wayland.

Compared to X11, Wayland has excellent support for smooth scrolling, soft taps, and pinch to zoom. Wayland is the default compositor in Ubuntu 24.10 and newer.


## Thanks

This driver is based on the work of @RicardoEPRodrigues, @robotrovsky, @svartalf, @0xABAD, and probably others. Thank you!

* https://github.com/RicardoEPRodrigues/magicmouse-hid
* https://github.com/ponyfleisch/hid-magictrackpad2
* https://github.com/adam-h/Linux-Magic-Trackpad-2-Driver
* https://github.com/bobbysue/Linux-Magic-Trackpad-2-Driver
* https://github.com/svartalf/hid-magicmouse2
