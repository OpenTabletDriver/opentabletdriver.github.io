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

## Bugs caused by Eto {#eto-bugs}

### [#1821 - Multikey bindings doesn't respect keyboard layout](https://github.com/OpenTabletDriver/OpenTabletDriver/issues/1821) {#multikey-binding-keyboard-layout}

For non-QWERTY users (e.g. AZERTY), you may experience that keyboard bindings
are read correctly in the GUI, but sent as a QWERTY keycode by the daemon.

Eto only allows us to read the processed keyboard layout.

This is planned to be fixed with the migration to Avalonia.

There are 2 known workarounds:

#### Workaround 1: Temporarily Use QWERTY when setting up keys {#multikey-binding-keyboard-layout-workaround1}

- Change your keyboard layout to QWERTY
- Set up the bindings you want to use, clicking your normal keys
- Change your keyboard layout back to the one you want to use

#### Workaround 2: Force Virtual Keyboard to use U.S. English layout (Linux only) {#multikey-binding-keyboard-layout-workaround2}

Keyboard Layouts are system-wide on Windows on MacOS.

##### Sway window manager

Put this _after_ any other keyboard configuration:

```conf
input '0:0:OpenTabletDriver_Virtual_Keyboard' {
    xkb_layout us
}
```

##### X11 Window Manager

TODO

## Assorted Bugs {#general-bugs}

### [#3834 - Eraser behavior may be spotty on Linux](https://github.com/OpenTabletDriver/OpenTabletDriver/issues/3834)
### [#3804 - Daemon IPC is not multi-user friendly](https://github.com/OpenTabletDriver/OpenTabletDriver/issues/3804)
### [#3515 - Tablet firmware version featureset variations are difficult to detect](https://github.com/OpenTabletDriver/OpenTabletDriver/issues/3515)
### [#3266 - Flatpak release does not install udev rules or kernel module blacklist](https://github.com/OpenTabletDriver/OpenTabletDriver/issues/3266)
### [#3179 - Setup Wizard will constantly pop up as long as user never saves a config](https://github.com/OpenTabletDriver/OpenTabletDriver/issues/3179)
### [#3171 - Some tablets may not work coming out of systemd sleep/suspend](https://github.com/OpenTabletDriver/OpenTabletDriver/issues/3171)
### [#2964 - (Linux only?) Monitor layouts with negative offsets may confuse GUI quick-settings](https://github.com/OpenTabletDriver/OpenTabletDriver/issues/2964)
### [#2955 - Disconnecting tablets mid-event (e.g. button press) may cause the button to remain pressed](https://github.com/OpenTabletDriver/OpenTabletDriver/issues/2957)
### [#2536 - CLI is unmaintained](https://github.com/OpenTabletDriver/OpenTabletDriver/issues/2536)

Also [#1952 - Command `setoutputmode` not working](https://github.com/OpenTabletDriver/OpenTabletDriver/issues/1952)

### [#2510 - Bindings do not accomodate select output mode / Mouse buttons not working in Windows Ink or Artist Mode](https://github.com/OpenTabletDriver/OpenTabletDriver/issues/2510)
### [#2106](https://github.com/OpenTabletDriver/OpenTabletDriver/issues/2106)/[#1855](https://github.com/OpenTabletDriver/OpenTabletDriver/issues/1855) (Linux/MacOS only) Daemon may misbehave if stdout is lost
### [#1666 - Similar tablets are not separately addressible](https://github.com/OpenTabletDriver/OpenTabletDriver/issues/1666)
### [#1143 - Monitor layout changes are not detected and require a daemon restart](https://github.com/OpenTabletDriver/OpenTabletDriver/issues/1143)
### [#1071 - Output may be up to 1 pixel off intended pixel on some configurations](https://github.com/OpenTabletDriver/OpenTabletDriver/issues/1071)

## Niche bugs (for plugin developers or similar) {#niche-bugs}

### [#3830 - External daemon-interacting applications may desynchronize settings shown in GUI](https://github.com/OpenTabletDriver/OpenTabletDriver/issues/3830)

## Feature Requests

Instead of listing all planned features (which would be a lot of work), look
for issues with the `enhancement` tag and looking at issues with a set milestone:
[example search](https://github.com/OpenTabletDriver/OpenTabletDriver/issues?q=is%3Aissue%20state%3Aopen%20label%3Aenhancement%20has%3Amilestone)
