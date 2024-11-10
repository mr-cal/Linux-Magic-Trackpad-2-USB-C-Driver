# Linux Apple Magic Trackpad 2 USB-C Driver

> [!WARNING]

> This driver adds support for the 2024 USB-C version of the Magic Trackpad 2. Upstream support in the kernel can be found [here](https://patchwork.kernel.org/project/linux-input/patch/20241110002816.6064-1-callahankovacs@gmail.com/).

> Older Magic devices are supported with kernel version 5.15 and newer.

> I have not tested or added support for the 2024 USB-C Magic Keyboard or 2024 USB-C Magic Mouse, because I do not own them. PRs are welcome or you can send me some hardware!

This repository contains the Linux hid-magicmouse driver with Magic Trackpad 2 USB-C support.

This driver is based on the work of @RicardoEPRodrigues, @robotrovsky, @svartalf, @0xABAD, and probably others. Thank you!

## Install Driver with DKMS

Setup/install with:

```bash
sudo apt-get install dkms
git clone https://github.com/mr-cal/Linux-Magic-Trackpad-2-USB-C-Driver.git
cd Linux-Magic-Trackpad-2-USB-C-Driver
chmod u+x install.sh
sudo ./install.sh
```

## Uninstall Driver

```bash
sudo ./remove.sh
```

## Apple Magic Trackpad 2

The driver supports Bluetooth and USB for the trackpad. To connect the Trackpad via Bluetooth, it must be clicked once after it is turned on, then the Trackpad tries to reconnect to the last paired (and trusted) connection.

## Apple Magic Mouse 2

The driver supports regular mouse motion and, additionally, scrolling and mouse middle click. Middle click is a single finger click near the middle portion of the touch surface OR a 3 finger click anywhere on the touch surface if you put the mouse in 3 finger middle click mode. Scrolling is a single finger up or down motion anywhere on the touch surface.

### Changing Parameters

Several parameters are available for you to modify to personalize the driver to your taste. These can be found in `/etc/modprobe.d/hid-magicmouse.conf` after install. Modify them and the next time the driver is loaded it will have the new values.

### Reloading the driver

After changing the parameters the driver can be reloaded using the following commands:

```
sudo rmmod hid_magicmouse
sudo modprobe hid_magicmouse
```

## Data Layout of Bluetooth packets.

```
		/* The data layout for magic mouse 2 is:
		 * 14 bytes of prefix
		 * data[0] is the device report ID
		 * data[1] is the mouse click events. Value of 1 is left, 2 is right.
		 * data[2] (contains lsb) and data[3] (msb) are the x movement
		 *         of the mouse 16bit representation.
		 * data[4] (contains msb) and data[5] (msb) are the y movement
		 *         of the mouse 16bit representation.
		 * data[6] data[13] are unknown so far. Need to decode this still
		 *
		 * data[14] onwards represent touch data on top of the mouse surface
		 *          touchpad. There are 8 bytes per finger. e.g:
		 * data[14]-data[21] will be the first finger detected.
		 * data[22]-data[29] will be finger 2 etc.
		 * these sets of 8 bytes are passed in as tdata to
		 * magicmouse_emit_touch()
		 *
		 * npoints is the number of fingers detected.
		 * size is minimum 14 but could be any multpiple of 14+ii*8 based on
		 * how many fingers are detected. e.g for 1 finger, size=22 for
		 * 2 fingers, size=30 and so on.
		 */

        /* tdata is 8 bytes per finger detected.
		 * tdata[0] (lsb of x) and least sig 4bits of tdata[1] (msb of x)
		 *          are x position of touch on touch surface.
		 * tdata[1] most sig 4bits (lsb of y) and and tdata[2] (msb of y)
		 *          are y position of touch on touch surface.
		 * tdata[1] bits look like [y y y y x x x x]
		 * tdata[3] touch major axis of ellipse of finger detected
		 * tdata[4] touch minor axis of ellipse of finger detected
		 * tdata[5] contains 6bits of size info (lsb) and the two msb of tdata[5]
		 *          are the lsb of id: [id id size size size size size size]
		 * tdata[6] 2 lsb bits of tdata[6] are the msb of id and 6msb of tdata[6]
		 *          are the orientation of the touch. [o o o o o o id id]
		 * tdata[7] 4 msb are state. 4lsb are unknown.
		 *
		 * [ x x x x x x x x ]
		 * [ y y y y x x x x ]
		 * [ y y y y y y y y ]
		 * [touch major      ]
		 * [touch minor      ]
		 * [id id s s s s s s]
		 * [o o o o o o id id]
		 * [s s s s | unknown]
		 */
```

## Thanks
* https://github.com/RicardoEPRodrigues/magicmouse-hid
* https://github.com/ponyfleisch/hid-magictrackpad2
* https://github.com/adam-h/Linux-Magic-Trackpad-2-Driver
* https://github.com/bobbysue/Linux-Magic-Trackpad-2-Driver
* https://github.com/svartalf/hid-magicmouse2
