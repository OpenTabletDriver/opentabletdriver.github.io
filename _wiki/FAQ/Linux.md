---
title: "Linux FAQ"
---

### My tablet is not detected?

#### Tablet Connection

Make sure that the tablet is actually plugged in to your computer properly. Check this by running `lsusb` in a terminal or by watching the output of `dmesg` or `udevadm monitor` when plugging in the tablet.

OpenTabletDriver currently has _no support_ for tablets connected via Bluetooth. Make sure that your tablet is connected via USB. There is partial support for tablets connected via wireless dongle.

Once the tablet is connected properly, verify if your tablet is in the list of supported tablets [here]({% link _sections/Tablets.md %}). If it is not, you may do one of the following:

- [Create a tablet support request in Github.](https://github.com/OpenTabletDriver/OpenTabletDriver/issues/new?assignees=&labels=configuration&projects=&template=tablet_configuration.yml&title=Add+support+for+)
- [Create a tablet support thread in #config-creation channel of the Discord server.]({% link _sections/Discord.md %})
- [Make your own tablet configuration.]({% link _wiki/Development/AddingTabletSupport.md %})

#### Troubleshooting

If your tablet is connected properly and is supported, but is still not detected, [check logs]({% link _wiki/Documentation/Logs.md %}) for any errors or warnings. If you find any, try finding for a match and its accompanying solution below:

##### UCLogic kernel module is loaded {#hid_uclogic}

_Symptoms_

```
Another tablet driver found: UC Logic
```

```
ArgumentOutOfRangeException: Value range is [0, 15]. (Parameter 'value)
```

[_Solution_]({% link _wiki/Documentation/UdevRules.md %})

##### Insufficient permissions {#udev}

_Symptoms_

```
Not permitted to open HID class device at /dev/hidrawX
```

[_Solution_]({% link _wiki/Documentation/UdevRules.md %})

#### Tablet-specific Troubleshooting

##### CTL-x100

It is possible for CTL-x100 tablets to boot in Android mode (the mode they use when interfacing with android devices like phones) instead of PC mode in some rare cases. To fix this, press
the outer 2 express keys for 3-4 seconds until the LEDs change brightness. This toggles the tablet's operating mode
between PC (high LED brightness) and Android mode (low LED brightness).

> Note: If you are sure your tablet is in PC mode, please follow the general instructions [here](#my-tablet-is-not-detected).

### Tablet is detected but not working?

#### Fresh Install {#fail-virtual-device}

If this is a fresh install and you have not configured your tablet yet, [check logs]({% link _wiki/Documentation/Logs.md %}) for any errors or warnings. If you find any, try finding for a match and its accompanying solution below:

##### Missing uinput device

_Symptoms_

```
Failed to initialize virtual tablet. (error code ENODEV)
```

_Solution_

Reboot your computer.

##### Missing uinput device support

_Symptoms_

```
Failed to initialize virtual tablet. (error code ENOENT)
```

_Solution_

Make sure that your kernel has uinput support. If you are using a custom kernel or builds kernel from source, make sure that you have enabled `CONFIG_INPUT_UINPUT` in your kernel configuration. Refer to your distro's documentation regarding kernel configuration.

##### Missing uinput device permissions

_Symptoms_

```
Failed to initialize virtual tablet. (error code EACCES)
```

[_Solution_]({% link _wiki/Documentation/UdevRules.md %})

#### Non-fresh Install

Try disabling your filters one-by-one and see if input finally works.

### My cursor is stuck in osu!lazer (Wayland) {#osu-lazer-broken-input-wayland}

Make sure you set the `SDL_VIDEODRIVER` to `wayland`. Some examples:

```bash
env SDL_VIDEODRIVER=wayland ./osu.AppImage
```

```bash
env SDL_VIDEODRIVER=wayland osu-lazer
```

### Tablet is working but there is no pressure {#artist-mode}

Pressure support is available by changing the output mode of OpenTabletDriver to Artist Mode:

- Change output mode (at the bottom left of OpenTabletDriver) to Artist Mode.
- Remove Tip Binding in the Pen Settings panel by opening advanced binding editor (press '...' next to the binding), then press "Clear".
- Save your settings and then try drawing in an application that supports pressure.

You will also need to use artist mode mouse bindings in the advanced binding editor instead of regular mouse buttons. Regular mouse buttons are _not_ supported in artist mode.

### The daemon does not start on boot

#### systemd {#systemd-autostart}

Make sure that you have enabled the systemd service:

```bash
systemctl user enable opentabletdriver.service --now
```

If this does not work, this means that the desktop environment is not configured correctly to integrate with systemd. In such case, refer to your desktop environment's documentation on how to autostart processes on login. The command to execute on login is:

```bash
otd-daemon
```

#### Other init systems

OpenTabletDriver offers no official support for other init systems. Refer to your init system's documentation on how to autostart processes on login. The command to execute on login is:

```bash
otd-daemon
```

> This command should be run as user, not root.

### The cursor feels slow on Artist Mode

Using artist mode will result in some minor smoothing due to libinput's tablet handling.

To disable this smoothing, add the contents below to `/etc/libinput/local-overrides.quirks`:

```ini
[OpenTabletDriver Virtual Tablets]
MatchName=OpenTabletDriver*
AttrTabletSmoothing=0
```

You should restart the OpenTabletDriver daemon after updating this file.

### I have tried these solutions, but my problem still persists! {#discord}

If you are still encountering problems with OpenTabletDriver,
it will be easier to help you over in our [Discord]({% link _sections/Discord.md %}) server. We will guide you in doing certain debugging steps and will give you different instructions to help resolve your problem.
