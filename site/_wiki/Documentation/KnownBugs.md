---
title: Known Bugs
---

## Introduction {#introduction}

OpenTabletDriver still has some fundamental and sometimes hard to fix bugs.
This page tries to document the bigger ones.

The `0.6.x` branch is based on the GUI framework Eto, and the `avalonia`
branch, which will eventually be migrated into `master`, is based on the GUI
framework Avalonia.

Many of these bugs have a planned milestone to be fixed in.

## Notable OpenTabletDriver bugs {#notable-bugs}

These bugs are likely to affect a sizable portion of users

### Monitor layout changes are not automatically detected {#monitor-layout-changes-not-detected}

If you change your monitor layout (such as resolution, position, rotation, or
similar) in your system settings, you need to restart the OpenTabletDriver
daemon completely.

See [OpenTabletDriver issue #1143](https://github.com/OpenTabletDriver/OpenTabletDriver/issues/1143)
for more details.

### Bindings do not accomodate selected output mode (Mouse buttons not working in Windows Ink or Linux Artist Mode) {#eto-keyboard-reading-is-weird}

While Adaptive Bindings try to solve this issue, users using specific bindings
(e.g. Mouse Button Binding on Windows Ink/Linux Artist Mode) will find that
their bindings are not working.

To help users diagnose this, OpenTabletDriver v0.6.7 logs an error when using
(built-in) bindings with unsupported output modes.

The primary cause for this is that the output modes are restricted from
outputting these events to the operating system.

See [OpenTabletDriver issue #2078](https://github.com/OpenTabletDriver/OpenTabletDriver/issues/2078)
for more details.

### Multikey bindings don't respect keyboard layout {#multikey-binding-keyboard-layout}

For non-QWERTY users (e.g. AZERTY or QWERTZ), you may experience that keyboard bindings
are read correctly in the GUI, but sent as a QWERTY keycode by the daemon.

This occurs because Eto reads filtered keycodes for setting bindings in the GUI but OpenTabletDriver outputs the raw keycodes associated with these bindings. The operating system then applies your keyboard/language filtering to the raw keycode, transforming it into something unexpected.

Eto only allows us to read the processed keyboard layout.

This is planned to be fixed with the migration to Avalonia.

See [OpenTabletDriver issue #1821](https://github.com/OpenTabletDriver/OpenTabletDriver/issues/1821)
for more details.

How to work around this depends on your operating system:

#### System-wide keyboard layout: Temporarily use U.S. English layout when setting up keys {#multikey-binding-keyboard-layout-system-wide-layouts}

Suitable for:

- Windows
- macOS
- Linux users with system-wide keyboard layouts (some X11 setups)

How to apply the workaround:

1. Change your keyboard layout to QWERTY
2. Set up the bindings you want to use, clicking your normal keys
3. Change your keyboard layout back to the one you want to use

This way, operating systems with system-wide keyboard layouts will emit the
intended keys, despite the resulting button possibly seeming incorrect.

#### Per-keyboard layout: Force Virtual Keyboard to use U.S. English layout {#multikey-binding-keyboard-layout-linux-per-keyboard-layouts}

> **Note:** This section normally only applies to Linux users

How to do this depends on your software stack:

- Wayland-based stacks must configure this in their Desktop Environment's (KDE/Gnome/sway/etc) settings
- X11-based display stacks must change X11 `xorg.conf` settings (see `man 5 xorg.conf`), or use `setxkbmap` during runtime.

##### X11 {#multikey-binding-keyboard-layout-linux-X11}

Unless you're using special configuration (`setxkbmap -device <ID>` / udev rule
`ENV{XKBLAYOUT}` / similar), chances are you're using a system-wide keyboard
layout.

In that case, follow the workaround presented for
[System-wide keyboard layout](#multikey-binding-keyboard-layout-system-wide-layouts) users.

If it turns out that this doesn't work anyway, make sure the virtual keyboard
from OpenTabletDriver is assigned the US-American layout.

##### Sway window manager {#multikey-binding-keyboard-layout-linux-sway}

Put this *after* any other keyboard configuration:

```conf
input '0:0:OpenTabletDriver_Virtual_Keyboard' {
    xkb_layout us
}
```

### Some tablets may not work coming out of system sleep/suspend {#sleep-wakeup-is-inconsistent}

Replugging the device always fixes this.

See [OpenTabletDriver issue #3171](https://github.com/OpenTabletDriver/OpenTabletDriver/issues/3171)
for more details.

### Disconnecting tablets mid-event (e.g. button press) causes the event to remain held (button permanently pressed) {#disconnected-tablets-do-not-reset-pipeline}

The only known workaround is to restart the daemon or send the same type of
event again (e.g. from the reconnected or another device)

See [OpenTabletDriver issue #2955](https://github.com/OpenTabletDriver/OpenTabletDriver/issues/2957)
for more details.

### (Linux) Flatpak release does not install udev rules or kernel module blacklist {#flatpak-missing-permissions}

This means that the Flatpak release may show no tablets detected, caused by
missing permissions or conflicting drivers.

Follow the instructions from the description of the Flatpak package to set these up properly.

See [OpenTabletDriver issue #3266](https://github.com/OpenTabletDriver/OpenTabletDriver/issues/3266)
for more details.

## Assorted OpenTabletDriver Bugs {#general-bugs}

These bugs are unlikely to be encountered by users, but have been seen in the wild.

### Similar tablets are not separately addressible {#single-tablet-per-tablet-model}

This means if you have tablets of the same model then only the first iterated
matching device will work.

There is no known workaround. The driver is fundamentally not prepared for
multiple models of the same device.

See [OpenTabletDriver issue #1666](https://github.com/OpenTabletDriver/OpenTabletDriver/issues/1666)
for more details.

### Output may be up to 1 pixel off intended pixel on some configurations {#output-one-pixel-off}

This is practically speaking not noticeable and as such is not prioritized at all.
It is unclear which setups are affected.

See [OpenTabletDriver issue #1071](https://github.com/OpenTabletDriver/OpenTabletDriver/issues/1071)
for more details.

## Niche bugs {#niche-bugs}

These bugs are unlikely to affect any users at all aside from esoteric or unsupported setups

### Daemon and GUI may misbehave if daemon's stdout is lost {#stdout-required}

Backgrounding the daemon without sending its output to a valid file (or pipe)
is not supported yet.

See OpenTabletDriver issues [#2106](https://github.com/OpenTabletDriver/OpenTabletDriver/issues/2106)
and [#1855](https://github.com/OpenTabletDriver/OpenTabletDriver/issues/1855) for more details
