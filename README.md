# Linux Apple Magic Trackpad 2 USB-C Driver

Adds support for the 2024 USB-C version of the Magic Trackpad 2. Upstream support in the kernel can be found [here](https://patchwork.kernel.org/project/linux-input/patch/20241110002816.6064-1-callahankovacs@gmail.com/).

This is not needed for older Apple Magic devices, which are supported in kernel version 5.15+.

I have not tested or added support for the 2024 USB-C Magic Keyboard or Magic Mouse because I do not own them. PRs are welcome or you can send me some hardware!

## Install

### dkms

To install the driver on non-debian distros, install `dkms` and use the installer script:

```bash
sudo apt install dkms # or yum, pacman, etc
git clone https://github.com/mr-cal/Linux-Magic-Trackpad-2-USB-C-Driver.git
cd Linux-Magic-Trackpad-2-USB-C-Driver
chmod u+x install.sh
sudo ./install.sh
```

### Github release

For Debian, Ubuntu, and derivatives, you can download and install the published deb package [here](https://github.com/mr-cal/Linux-Magic-Trackpad-2-USB-C-Driver/releases) and install it with:

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

To reload the driver:

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

The out-of-box experience with Magic Trackpads is significantly better with Wayland compared to X11.

| setup | usual default featureset |
| -- | -- |
| no driver | point, hard left click |
| driver + X11 | point, hard left/right clicks, scroll |
| driver + wayland | point, hard/soft left/right clicks, smooth scroll, zoom |

Additional gestures can be configured with [touchegg](https://github.com/JoseExposito/touchegg).

## Secure boot

If you haven't installed an unofficial driver before, be advised that you must disable secure boot, use a kernel that does not require signed drivers, or self-sign the driver. See [here](https://askubuntu.com/questions/755238/why-disabling-secure-boot-is-enforced-policy-when-installing-3rd-party-modules) for more information.

## Thanks

This driver is based on the work of @RicardoEPRodrigues, @robotrovsky, @svartalf, @0xABAD, and probably others. Thank you!

* https://github.com/RicardoEPRodrigues/magicmouse-hid
* https://github.com/ponyfleisch/hid-magictrackpad2
* https://github.com/adam-h/Linux-Magic-Trackpad-2-Driver
* https://github.com/bobbysue/Linux-Magic-Trackpad-2-Driver
* https://github.com/svartalf/hid-magicmouse2
