# Linux Apple Magic USB-C Driver

### *Driver support for the 2024 USB-C versions of the Magic Trackpad 2 and Magic Mouse 2.*

## Upstream support

A [kernel patch](https://patchwork.kernel.org/project/linux-input/patch/20241110002816.6064-1-callahankovacs@gmail.com/) for the trackpad has been accepted and backported to LTS kernels. It's available in:

* 6.1 LTS - 6.1.120 and newer
* 6.6 LTS - 6.6.66 and newer
* 6.12 LTS - 6.12.5 and newer
* 6.13 and newer

This is not needed for Apple Magic devices with lightning port connectors, which are supported in kernel version 5.15+.

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

## Configure libinput
For better responsibility, specially multi touch gestures, libinput parameters need to be implemented, if not supported already. An [upstream patch](https://gitlab.freedesktop.org/libinput/libinput/-/commit/b566d64c172bc397f47a07edbd9d9c1a755595ce) for the trackpad has been accepted already.
More information can be found [here](https://askubuntu.com/questions/1283762/custom-libinput-quirk-for-apple-magic-trackpad-2).  

To configure the Apple Magic Trackpad Parameters for libinput create quirks file `/usr/share/libinput/local-overrides.quirks` with following content:  
```bash
[Apple Magic Trackpad USB-C (Bluetooth)]
MatchBus=bluetooth
MatchVendor=0x004C
MatchProduct=0x0324
AttrTouchSizeRange=20:10
AttrPressureRange=3:0
AttrPalmSizeThreshold=900
AttrThumbSizeThreshold=700

[Apple Magic Trackpad USB-C (USB)]
MatchBus=usb
MatchVendor=0x05AC
MatchProduct=0x0324
AttrTouchSizeRange=20:10
AttrPressureRange=3:0
AttrPalmSizeThreshold=900
AttrThumbSizeThreshold=700
```

## Data Layout of Trackpad

```bash
x: are x position of touch on touch surface
y: are y position of touch on touch surface
s: are state
touch_major: touch major axis of ellipse of finger detected
touch_minor: touch minor axis of ellipse of finger detected
size: size info
pressure: pressure of touch on touch surface
o: orientation of the touch on touch surface
i: id of touch
?: Unknown data
[ x x x x x x x x ]
[ y y y x x x x x ]
[ y y y y y y y y ]
[ s s ? ? ? ? y y ]
[ touch_major     ]
[ touch_minor     ]
[ size            ]
[ pressure        ]
[ o o o ? i i i i ]
```

## Wayland and X11

The out-of-box experience with Magic Trackpads is significantly better with Wayland compared to X11.

| setup | usual default featureset |
| -- | -- |
| no driver | point, hard left click |
| driver + X11 | point, hard left/right clicks, scroll, three-finger middle mouse button |
| driver + wayland | point, hard/soft left/right clicks, smooth scroll, zoom, three-finger middle mouse button |

Additional gestures can be configured with [touchegg](https://github.com/JoseExposito/touchegg) or [libinput-gestures](https://github.com/bulletmark/libinput-gestures).


## Secure boot

If you haven't installed an unofficial driver before, be advised that you must disable secure boot, use a kernel that does not require signed drivers, or self-sign the driver. See [here](https://askubuntu.com/questions/755238/why-disabling-secure-boot-is-enforced-policy-when-installing-3rd-party-modules) for more information.

## Apple Magic Keyboard USB-C

Support for the USB-C version of the Apple magic keyboard is not supported by the project because it is a different driver.
Upstream support can be found [here](https://patchwork.kernel.org/project/linux-input/patch/20250112041314.11661-1-YevgenVovk@ukr.net/).

## Thanks

This driver is based on the work of @SeDi343, @RicardoEPRodrigues, @robotrovsky, @svartalf, @0xABAD, and others. Thank you!

* https://github.com/RicardoEPRodrigues/magicmouse-hid
* https://github.com/ponyfleisch/hid-magictrackpad2
* https://github.com/adam-h/Linux-Magic-Trackpad-2-Driver
* https://github.com/bobbysue/Linux-Magic-Trackpad-2-Driver
* https://github.com/svartalf/hid-magicmouse2
