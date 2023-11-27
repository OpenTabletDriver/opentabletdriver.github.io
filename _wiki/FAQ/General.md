---
title: General FAQ
---

### Is my tablet supported? {#supported-tablets}

Verify if your tablet is in the list of supported tablets [here]({% link _sections/Tablets.md %}). If it is not, you may do one of the following:

- [Create a tablet support request in Github.](https://github.com/OpenTabletDriver/OpenTabletDriver/issues/new?assignees=&labels=configuration&projects=&template=tablet_configuration.yml&title=Add+support+for+)
- [Create a tablet support thread in #config-creation channel of the Discord server.]({{ site.discord_invite_url }})
- [Write the tablet configuration.]({% link _wiki/Development/AddingTabletSupport.md %})

---

### My tablet is supported but not detected? {#tablet-not-detected}

OpenTabletDriver currently has _no support_ for tablets connected via Bluetooth. Make sure that your tablet is connected via USB. There is partial support for tablets connected via wireless dongle.

Once plugged in, determine if your tablet has good connection to the computer:

- Windows
    - Windows by default will play a sound when a device is plugged in. If you do not hear this sound, consider using a different port or replacing the cable (make sure the cable supports both power and data transfer).
- Linux
    - Check this by running `lsusb` in a terminal or by watching the output of `dmesg` or `udevadm monitor` when plugging in the tablet.

Then check [above](#supported-tablets) if your tablet is supported. If it is and there are still problems, check the troubleshoot sections:

- [Windows]({% link _wiki/FAQ/Windows.md %}#troubleshooting)
- [Linux]({% link _wiki/FAQ/Linux.md %}#troubleshooting)
- [macOS]({% link _wiki/FAQ/MacOS.md %}#troubleshooting)

or alternatively, see if there is a [tablet specific FAQ]({% link _wiki/FAQ/TabletSpecific.md %}) for your tablet.

---

### Where are my settings and plugins stored? {#appdata}

The following table describes the location of the default application data directory for each operating system:

| Operating System | Path |
| --- | --- |
| Windows | `%localappdata%\OpenTabletDriver` |
| Linux | `~/.config/OpenTabletDriver` |
| macOS | `~/Library/Application Support/OpenTabletDriver` |

Its contents are as follows:

| Entry | Type | Description |
| --- | --- | --- |
| `settings.json` | File | Stores the driver settings |
| `tablet-data.txt` | File | Stores the recorded tablet data from Tablet Debugger |
| `daemon.log` | File | Contains a stack trace when daemon crashes |
| Backup | Directory | Contains backups of OpenTabletDriver binaries and settings triggered by updates |
| Cache | Directory | Contains cached Github data for fast browsing within Plugin Manager |
| Plugins | Directory | Contains plugins. This should not be manually modified unless you know what you're doing |
| Presets | Directory | Contains saved presets |

---

### My cursor is going crazy! It teleports everywhere! {#emi-interference}

This is caused by electromagnetic interference (EMI) from other devices. Make sure that the tablet is not near any of the following:

- Powered cables (e.g. power cables, charging USB cables, etc.)
- Powered mouse pads
- Monitor
- On top of the laptop's keyboard

If certain that the tablet is not near any of the above, try replacing the pen. If the problem persists, replace the tablet. It's broken!

---

### I see two moving cursors when hovering my pen! {#two-cursors}

This is caused by another tablet driver running in the background. Make sure that you have
uninstalled all other tablet drivers before using OpenTabletDriver.

#### Windows

Run [TabletDriverCleanup](https://github.com/X9VoiD/TabletDriverCleanup/releases/latest) to remove
all other tablet drivers.

#### Linux

See [here]({% link _wiki/Documentation/RequiredPermissions.md %}#setup-linux).

#### macOS

Uninstall any other tablet drivers you have installed.

---

### How to convert areas to and from OpenTabletDriver? {#area-conversion}

#### Conversion through the UI

- Right click the tablet area editor
- Click the `convert item` menu item
- Select the OEM driver and insert your area values

#### Conversion through manual calculation

| Term | Definition |
| --- | --- |
| Width | The width of the area in millimeters |
| Height | The height of the area in millimeters |
| TWidth | The width of the tablet's digitizer in millimeters. Can be found in tablet's configuration file |
| THeight | The height of the tablet's digitizer in millimeters. Can be found in the tablet's configuration file |
| XOffset | The X offset of the center of the area in millimeters |
| YOffset | The Y offset of the center of the area in millimeters |
| LPI | Lines per inch, this is commonly 5080 or 2540 |

Use the following formulas to get values for the area editor's `Width`, `Height`, `XOffset`, and `YOffset` fields.

**Wacom and Veikk**

| Term | Definition |
| --- | --- |
| Left | The number of lines from the left side of the tablet to the left side of the area |
| Top | The number of lines from the top side of the tablet to the top side of the area |
| Right | The number of lines from the left side of the tablet to the right side of the area |
| Bottom | The number of lines from the top side of the tablet to the bottom side of the area |

Formula:

```
Width = (Right - Left) / LPI * 25.4
Height = (Bottom - Top) / LPI * 25.4
XOffset = (Left / LPI * 25.4) + (Width / 2)
YOffset = (Top / LPI * 25.4) + (Height / 2)
```

**XP-Pen**

| Term | Definition |
| --- | --- |
| XPW | The width in XP-Pen units. Denoted as `W` in XP-Pen's official drivers |
| XPH | The height in XP-Pen units. Denoted as `H` in XP-Pen's official drivers |
| XPX | The X offset of the top left corner of the area in XP-Pen units. Denoted as `X` in XP-Pen's official drivers |
| XPY | The Y offset of the top left corner of the area in XP-Pen units. Denoted as `Y` in XP-Pen's official drivers |

Formula:

```
Width = XPW / 3.937
Height = XPH / 3.937
XOffset = (Width / 2) + (XPX / 3.937)
YOffset = (Height / 2) + (XPY / 3.937)
```

**Huion and Gaomon**

| Term | Definition |
| --- | --- |
| Left | The percentage of the distance from the left side of the tablet to the left side of the area |
| Top | The percentage of the distance from the top side of the tablet to the top side of the area |
| Right | The percentage of the distance from the left side of the tablet to the right side of the area |
| Bottom | The percentage of the distance from the top side of the tablet to the bottom side of the area |

Formula:

```
Width = (Right - Left) * TWidth
Height = (Bottom - Top) * THeight
XOffset = (Width / 2) + (Left * TWidth)
YOffset = (Height / 2) + (Top * THeight)
```