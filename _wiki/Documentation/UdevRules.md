---
title: Udev Rules
---

Make sure that the installed OpenTabletDriver version is at least **0.6.3.0**. If still not working even with the latest version, refer to the instructions below depending on if you installed OpenTabletDriver via:

- [Package manager](#package-manager)
- [Built from source](#built-from-source)

### Package manager

#### Standard FHS distro

Run the following script in bash as root:

```bash
echo "Finding old udev rules..."
for c in /etc/udev/rules.d/9{0,9}-opentabletdriver.rules; do
  if [ -f "${c}" ]; then
    echo "Deleting ${c}"
    rm "${c}"
  fi
done

echo "Finding old kernel blacklist rules..."
if [ -f /etc/modprobe.d/blacklist.conf ]; then
  echo "Deleting /etc/modprobe.d/blacklist.conf"
  rm /etc/modprobe.d/blacklist.conf
done

udevadm control --reload-rules && udevadm trigger
```

> This script cleans up obsolete udev rules and reloads udev.

Then update the initramfs:

{:.table}
| Distro | Command |
| --- | --- |
| Arch Linux | `sudo mkinitcpio -P` |
| Debian/Ubuntu | `sudo update-initramfs -u` |

For other distros, refer to your distro's documentation on how to update the initramfs.

#### Non-standard FHS distro

Refer to your distro's documentation on how to remove udev rules of the name `90-opentabletdriver.rules` or `99-opentabletdriver.rules`.

### Built from source

Make sure you built OpenTabletDriver via [these instructions](https://github.com/OpenTabletDriver/OpenTabletDriver#linux) and extracted the generic binary tarball correctly.
