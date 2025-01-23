---
title: "Linux FAQ"
hide_from_auto_list: true
---

> It is recommended that you check [General FAQ]({% link _wiki/FAQ/General.md %}) first
before continuing.
{:.alert-primary}

> Also check out [Linux App Specific FAQ]({% link _wiki/FAQ/LinuxAppSpecific.md %}) for
app-specific instructions.

## My tablet is supported but not detected? {#troubleshooting}

> Read [General FAQ]({% link _wiki/FAQ/General.md %}#tablet-not-detected) first before continuing below if you haven't already.
{:.alert-warning}

### Common Problems

If your tablet is connected properly and is supported, but is still not detected, [check logs]({% link _wiki/Documentation/Logs.md %}) for any errors or warnings. If you find any, try finding for a match and its accompanying solution below:

#### Another driver is found {#hid_uclogic}

*Symptoms*:

```otdlog
Another tablet driver found: <driver>
```

*Solution*:

- [See here]({% link _wiki/Documentation/RequiredPermissions.md %}#setup-linux)

#### Insufficient permissions {#udev}

*Symptoms*:

```otdlog
Not permitted to open HID class device at /dev/hidrawX
```

*Solution*:

- [See here]({% link _wiki/Documentation/RequiredPermissions.md %})

## Tablet is detected but not working?

### Fresh Install {#fail-virtual-device}

If this is a fresh install and you have not configured your tablet yet, [check logs]({% link _wiki/Documentation/Logs.md %}) for any errors or warnings. If you find any, try finding for a match and its accompanying solution below:

#### Missing uinput device

*Symptoms*:

```otdlog
Failed to initialize virtual tablet. (error code ENODEV)
```

*Solution*:

- Reboot your computer.

#### Missing uinput device support

*Symptoms*:

```otdlog
Failed to initialize virtual tablet. (error code ENOENT)
```

Make sure that your kernel has uinput support. If you are using a custom kernel or builds kernel from source, make sure that you have enabled `CONFIG_INPUT_UINPUT` in your kernel configuration. Refer to your distro's documentation regarding kernel configuration.

#### Missing uinput device permissions

*Symptoms*:

```otdlog
Failed to initialize virtual tablet. (error code EACCES)
```

*Solution*:

- [See here]({% link _wiki/Documentation/RequiredPermissions.md %})

### Non-fresh Install

Try disabling your filters one-by-one and see if input finally works.

## Display mapping behaves unexpectedly on a multi-monitor setup {#multi-monitor-mapping-issues}

OpenTabletDriver's virtual device might be getting picked up by your desktop environment, which could be mapping its area to another monitor.

In order to avoid the two from conflicting, you will need to map one of the display area editors to all screens:

### In desktop environment {#multi-monitor-fix-in-de}

- Find your desktop environment's tablet settings page and, if possible, map the virtual device to all screens
- Set your intended area in OpenTabletDriver

Note that some desktop environments might not allow for such a configuration.

### In OpenTabletDriver {#multi-monitor-fix-in-otd}

- `Right click` the display area editor
- Select `Set to display` -> `Virtual Display`
- Save or apply your settings
- Set your intended area in your desktop environment's settings

## Tablet is working but there is no pressure {#artist-mode}

Pressure support is available by changing the output mode of OpenTabletDriver to Artist Mode:

- Change output mode (at the bottom left of OpenTabletDriver) to <kbd>Artist Mode</kbd>.
- Remove the tip binding in the Pen Settings panel by opening the advanced binding editor (press <kbd>...</kbd> next to the binding), then press <kbd>Clear</kbd>
- Save or apply your settings, and then try drawing in an application that supports pressure.

See [here](#artist-mode-bindings) for setting up bindings for Artist Mode.

## Mouse button bindings are not working when using Artist Mode {#artist-mode-bindings}

Artist mode does not support regular mouse buttons. You will need to use artist mode pen bindings in the advanced binding editor instead of regular mouse buttons.

## How to autostart daemon on boot? {#autostart}

### systemd {#systemd-autostart}

Make sure that you have enabled the systemd service:

```bash
systemctl --user enable opentabletdriver.service --now
```

If the daemon doesn't reliably autostart on boot, then the desktop environment is not
configured correctly to integrate with systemd.

In such case, refer to your desktop environment's documentation on how to autostart processes on
login using the instructions [below](#other-inits)

### Other init systems {#other-inits}

OpenTabletDriver offers no official support for other init systems. Refer to your init system's documentation on how to autostart processes on login. The command to execute on login is:

```bash
otd-daemon
```

> This command should be run as user, not root.

## The cursor feels slow on Artist Mode {#libinput-smoothing}

If you are using a release version of OpenTabletDriver v0.6.4.0 or older, this
is expected, and a workaround exists [below](#libinput-smoothing-on-old-versions).

On newer versions (v0.6.5.0 and up), this is fixed in packaging.

### With OpenTabletDriver Version 0.6.5.0 or newer

Smoothing on the virtual tablet provided by OpenTabletDriver should already be
disabled via packaging. You can verify that the attribute is set with the
`liblinput quirks list <path>` command.

Figuring out the path is left as an exercise for the reader, but it is
typically one of the **newest** (not necessarily highest numbered) `event##`
device in `/dev/input/`.

If this attribute is not set correctly, please report it the person responsible
for packaging OpenTabletDriver for your Linux distribution.

### With OpenTabletDriver Version 0.6.4.0 or earlier {#libinput-smoothing-on-old-versions}

With OpenTabletDriver v0.6.4.0 and earlier, using Artist Mode will result in
some minor smoothing due to libinput's tablet handling, for which the quirk is
not officially included in packaging.

To disable this smoothing manually, add the contents below to `/etc/libinput/local-overrides.quirks`:

```ini
[OpenTabletDriver Virtual Tablet]
MatchName=OpenTabletDriver*
AttrTabletSmoothing=0
```

You should restart the OpenTabletDriver daemon after updating this file.

## Still have problems? {#discord}

If you are still encountering problems with OpenTabletDriver, it will be easier to help you over in our [Discord]({{ site.data.links.project.DiscordInvite }}) server. We will guide you in doing certain debugging steps and will give you different instructions to help resolve your problem.
