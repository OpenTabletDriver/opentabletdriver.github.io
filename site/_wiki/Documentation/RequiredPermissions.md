---
title: Required Permissions
---

OpenTabletDriver requires certain permissions to be granted to it in order to function properly in
certain platforms.

## Windows {#windows}

OpenTabletDriver works out of the box on Windows. However, if you are using a tablet that requires
WinUSB, you will need to install the WinUSB driver.

Check the [list of supported tablets]({% link _sections/Tablets.md %}) to see if your tablet requires WinUSB. Then follow the instructions on [how to install WinUSB]({% link _wiki/Install/Windows.md %}#winusb).

WinUSB allows OpenTabletDriver to access the tablet by bypassing the default Windows HID driver
that takes exclusive access of the tablet.

## Linux {#linux}

OpenTabletDriver needs to be able to access `/dev/uinput` and several other sys paths related to
your tablet. On systemd-based distros, this is done via udev rules that defines the access level
granted to the user. There is no official support for non-systemd distros, but patches are welcome.

Currently, two kernel modules are also unloaded as they interfere with OpenTabletDriver. These are:

- `wacom`
- `hid_uclogic`

A kernel module blacklist is used to prevent these modules from loading on boot.

### Set up udev rules and kernel module blacklist {#setup-linux}

If for some reason the udev rules and the kernel module blacklist is not working, make sure that
the installed OpenTabletDriver version is at least **0.6.3.0**. If still not working even with the
latest version, refer to the instructions below depending on if you installed OpenTabletDriver via:

- [Package manager](#package-manager), or
- [Built from source](#built-from-source)

However if you're using a version of OpenTabletDriver _below_ **0.6.3.0** and somehow cannot update
to the latest version, refer to the [Legacy package](#legacy-package) section.

### Package manager

#### FHS distro

> Most distros follow the [FHS standard](https://refspecs.linuxfoundation.org/fhs.shtml), if you don't know if your distro follows this standard, it most likely does.

Run the following script in bash:

```bash
echo "Finding old udev rules..."
for c in /etc/udev/rules.d/9{0,9}-opentabletdriver.rules; do
  if [ -f "${c}" ]; then
    echo "Deleting ${c}"
    sudo rm "${c}"
  fi
done

echo "Finding old kernel module blacklist rules..."
if [ -f /etc/modprobe.d/blacklist.conf ]; then
  echo "Deleting /etc/modprobe.d/blacklist.conf"
  sudo rm /etc/modprobe.d/blacklist.conf
fi

sudo modprobe uinput
sudo rmmod wacom > /dev/null 2>&1
sudo rmmod hid_uclogic > /dev/null 2>&1

sudo udevadm control --reload-rules && sudo udevadm trigger
```

> This script cleans up obsolete udev rules, reloads udev and unloads kernel modules.

Then update the initramfs:

| Distro | Command |
| --- | --- |
| Arch Linux | `sudo mkinitcpio -P` |
| Debian/Ubuntu | `sudo update-initramfs -u` |

For other distros, refer to your distro's documentation on how to update the initramfs.

#### Legacy package on FHS distro {#legacy-package}

If you're using a version of OpenTabletDriver *below* 0.6.3.0 on an FHS distro, run the following script:

> Most distros follow the [FHS standard](https://refspecs.linuxfoundation.org/fhs.shtml), if you don't know if your distro follows this standard, it most likely does.

```bash
echo "Finding old udev rules..."
for c in /etc/udev/rules.d/9{0,9}-opentabletdriver.rules; do
  if [ -f "${c}" ]; then
    echo "Deleting ${c}"
    sudo rm "${c}"
  fi
done

echo "Finding old kernel module blacklist rules..."
if [ -f /etc/modprobe.d/blacklist.conf ]; then
  echo "Deleting /etc/modprobe.d/blacklist.conf"
  sudo rm /etc/modprobe.d/blacklist.conf
fi

git clone https://github.com/OpenTabletDriver/OpenTabletDriver.git
cd OpenTabletDriver

./generate-rules.sh | sudo tee /etc/udev/rules.d/70-opentabletdriver.rules
sudo cp ./eng/linux/Generic/usr/lib/modprobe.d/99-opentabletdriver.conf /etc/modprobe.d/99-opentabletdriver.conf
sudo cp ./eng/linux/Generic/usr/lib/modules-load.d/opentabletdriver.conf /etc/modules-load.d/opentabletdriver.conf

cd ..
rm -rf OpenTabletDriver

sudo modprobe uinput
sudo rmmod wacom > /dev/null 2>&1
sudo rmmod hid_uclogic > /dev/null 2>&1

sudo udevadm control --reload-rules && sudo udevadm trigger
```

Then update the initramfs:

| Distro | Command |
| --- | --- |
| Arch Linux | `sudo mkinitcpio -P` |
| Debian/Ubuntu | `sudo update-initramfs -u` |

For other distros, refer to your distro's documentation on how to update the initramfs.

#### Non-FHS distro

Refer to your distro's documentation on how to remove udev rules of the name
`90-opentabletdriver.rules` or `99-opentabletdriver.rules` and a kernel module blacklist named
`blacklist.conf` containing:

```
blacklist wacom
blacklist hid_uclogic
```

If there is no updated package available for your distro, you may try building from source. Consult
your distro's documentation on how to "install" the resulting generic binary tarball.

### Built from source

Make sure you built OpenTabletDriver via [these instructions](https://github.com/OpenTabletDriver/OpenTabletDriver#linux) and extracted the generic binary tarball correctly.

## macOS {#macos}

OpenTabletDriver requires the following permissions:

- *Accessibility* - for moving the cursor
- *Input Monitoring* - for reading current cursor position to send relative movements (relative mode)

To grant this, navigate to `Settings -> System Preferences -> Security and Privacy -> Privacy`, then check the permissions required. If they are already checked and problems persist, try unchecking then rechecking them.
