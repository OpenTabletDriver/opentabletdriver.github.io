---
title: General FAQ
---

## Is my tablet supported? {#supported-tablets}

Verify if your tablet is in the list of supported tablets [here]({% link _sections/Tablets.md %}). If it is not, you may do one of the following:

- [Create a tablet support request in Github.](https://github.com/OpenTabletDriver/OpenTabletDriver/issues/new?assignees=&labels=configuration&projects=&template=tablet_configuration.yml&title=Add+support+for+)
- [Create a tablet support thread in #config-creation channel of the Discord server.]({{ site.data.links.project.DiscordInvite }})
- [Write the tablet configuration.]({% link _wiki/Development/AddingTabletSupport.md %})

## My tablet is supported but not detected? {#tablet-not-detected}

OpenTabletDriver currently has *no support* for tablets connected via Bluetooth. Make sure that your tablet is connected via USB. There is partial support for tablets connected via wireless dongle.

Once plugged in, determine if your tablet has good connection to the computer:

- Windows
    - Windows by default will play a sound when a device is plugged in. If you do not hear this sound, consider using a different port or replacing the cable (make sure the cable supports both power and data transfer).
- Linux
    - Check this by running `lsusb` in a terminal or by watching the output of `dmesg` or `udevadm monitor` when plugging in the tablet.

Then check [above](#supported-tablets) if your tablet is supported. If it is and there are still problems, check the troubleshoot sections:

- [Windows]({% link _wiki/FAQ/Windows.md %}#troubleshooting)
- [Linux]({% link _wiki/FAQ/Linux.md %}#troubleshooting)
- [macOS]({% link _wiki/FAQ/MacOS.md %})

or alternatively, see if there is a [tablet model specific FAQ]({% link _wiki/FAQ/ModelSpecific.md %}) for your tablet.

## Where are my settings and plugins stored? {#appdata}

The following table describes the location of the default application data directory for each operating system:

{% include appdata-location.md %}

The application data directory contents are as follows:

|       Entry       |  Type  | Description |
| :---------------: | :----: | :---------- |
|  `settings.json`  |  File  | Stores the driver settings
| `tablet-data.txt` |  File  | Stores the recorded tablet data from Tablet Debugger
|   `daemon.log`    |  File  | Contains a stack trace if the daemon has crashed
|      Backup       | Folder | Contains old versions of OpenTabletDriver and its settings
|       Cache       | Folder | Contains cached metadata for the Plugin Manager
|      Plugins      | Folder | Contains installed plugins (`.dll` files). This folder should not be modified manually.
|      Presets      | Folder | Contains saved presets
{: .table .table-dark }

## My cursor is going crazy! It teleports everywhere! {#emi-interference}

This is caused by electromagnetic interference (EMI) from other devices. Make sure that the tablet is not near any of the following:

- Powered cables (e.g. power cables, charging USB cables, etc.)
- Powered mouse pads
- Monitor
- On top of the laptop's keyboard

If certain that the tablet is not near any of the above, try replacing the pen. If the problem persists, replace the tablet. It's broken!

## I see two moving cursors when hovering my pen! {#two-cursors}

This is caused by another tablet driver running in the background. Make sure that you have
uninstalled all other tablet drivers before using OpenTabletDriver.

### Windows

Run [TabletDriverCleanup]({{ site.data.links.external.TabletDriverCleanup.latest }}) to remove
all other tablet drivers.

### Linux

See [here]({% link _wiki/Documentation/RequiredPermissions.md %}#setup-linux).

### macOS

Uninstall any other tablet drivers you have installed.

## Does OpenTabletDriver support pen pressure? {#pressure}

All of our supported tablets has full pen pressure support unless otherwise noted on
the [Tablets]({% link _sections/Tablets.md %}) page.

However, to make the driver output the pressure to your operating system, you may need to perform some changes:

| Operating System |   Wiki Link   | Notes |
| :--------------: | :-----------: | :---- |
|      Windows     | [Windows Ink] | A virtual device driver (VMulti) and the Windows Ink plugin is needed
|       Linux      | [Artist Mode] | Built-in, simply change the output mode of OpenTabletDriver
|       MacOS      |  unsupported  | This is a work in progress, and is expected with the 0.7 release of OpenTabletDriver
{: .table .table-dark }

[Windows Ink]: {% link _wiki/FAQ/Windows.md %}#win-ink
[Artist Mode]: {% link _wiki/FAQ/Linux.md %}#artist-mode

## How to convert areas to and from OpenTabletDriver? {#area-conversion}

### Conversion through the OpenTabletDriver UI

- Right click the Tablet Area Editor
- Click the <kbd>Convert Item</kbd> menu item
- Select the OEM driver to convert from, then input the appropriate values to the converter

### Conversion through manual calculation

Use this reference chart for the upcoming formulas:

|  Term   | Definition |
| :-----: | :--------- |
|  Width  | The width of the area in millimeters
| Height  | The height of the area in millimeters
| TWidth  | The width of the tablet's digitizer in millimeters. Can be found in the tablet's configuration file.
| THeight | The height of the tablet's digitizer in millimeters. Can be found in the tablet's configuration file.
| XOffset | The X offset of the center of the area in millimeters
| YOffset | The Y offset of the center of the area in millimeters
|   LPI   | Lines per inch, this is commonly 5080 or 2540
{: .table .table-dark }

`TWidth` and `THeight` can be found in the tablet's configuration file.

Use the following formulas to get values for OpenTabletDriver's area editor's `Width`, `Height`, `XOffset`, and `YOffset` fields:

#### Wacom and Veikk

|  Term  | Definition |
| :----: | :--------- |
|  Left  | The number of lines from the left side of the tablet to the left side of the area
|  Top   | The number of lines from the top side of the tablet to the top side of the area
| Right  | The number of lines from the left side of the tablet to the right side of the area
| Bottom | The number of lines from the top side of the tablet to the bottom side of the area
{: .table .table-dark }

**Formula**:

```py
Width   = (Right - Left) / LPI * 25.4
Height  = (Bottom - Top) / LPI * 25.4
XOffset = (Width  / 2) + (Left / LPI * 25.4)
YOffset = (Height / 2) + (Top  / LPI * 25.4)
```

#### XP-Pen

| Term | Definition |
| :--: | :--------- |
| XPW  | The width in XP-Pen units. Denoted as `W` in XP-Pen's official drivers.
| XPH  | The height in XP-Pen units. Denoted as `H` in XP-Pen's official drivers.
| XPX  | The X offset of the top left corner of the area in XP-Pen units. Denoted as `X` in XP-Pen's official drivers.
| XPY  | The Y offset of the top left corner of the area in XP-Pen units. Denoted as `Y` in XP-Pen's official drivers.
{: .table .table-dark }

**Formula**:

```py
Width   = XPW / 3.937
Height  = XPH / 3.937
XOffset = (Width  / 2) + (XPX / 3.937)
YOffset = (Height / 2) + (XPY / 3.937)
```

#### Huion and Gaomon

|  Term  | Definition |
| :----: | --- |
|  Left  | The percentage of the distance from the left side of the tablet to the left side of the area
|  Top   | The percentage of the distance from the top side of the tablet to the top side of the area
| Right  | The percentage of the distance from the left side of the tablet to the right side of the area
| Bottom | The percentage of the distance from the top side of the tablet to the bottom side of the area
{: .table .table-dark }

**Formula**:

```py
Width   = (Right - Left) * TWidth
Height  = (Bottom - Top) * THeight
XOffset = (Width  / 2) + (Left * TWidth)
YOffset = (Height / 2) + (Top * THeight)
```
