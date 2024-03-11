---
title: Linux App-specific FAQ
---

## osu!stable

### osu! is not detecting input from my tablet (Wayland)

Do not use `Absolute Mode` as your output mode. Use `Artist Mode` instead. Wine and XWayland currently has issues with parsing absolute mouse input.

Please note that libinput adds smoothing on top of this output mode by default. See [here]({% link _wiki/FAQ/Linux.md %}#libinput-smoothing) for more information on how to remove the smoothing from Artist Mode.

## osu!Lazer

### My cursor is stuck (Wayland) {#osu-lazer-broken-input-wayland}

Make sure you set the `SDL_VIDEODRIVER` to `wayland`. Some examples:

```bash
env SDL_VIDEODRIVER=wayland ./osu.AppImage
```

```bash
env SDL_VIDEODRIVER=wayland osu-lazer
```

---

### Art Programs {#art}

Firstly, make sure your output mode is [set to Artist Mode]({% link _wiki/FAQ/Linux.md %}#artist-mode %})

You can confirm the setting is applied by running the following command and verifying that at least 1 listed device contains 'Artist' in the name.
```bash
libinput list-devices | grep -i OpenTabletDriver
```

If your program still does not work after ensuring the output mode has been set in the driver, please read on.

#### GIMP {#gimp}

1. Go to 'Edit -> Input Devices' in the GIMP Toolbar
2. Make sure any of the devices matching the following settings are set to 'Mode: Screen' in the right hand panel
    - `Core Pointer`
    - `xwayland-tablet eraser`, if present
    - `xwayland-tablet stylus`, if present
    - `OpenTabletDriver Virtual Artist Tablet Pen`, if present and on X11
    > Any devices not in the list above should have their Mode set to Disabled
3. Ensure your chosen tool supports pressure
    - Most tools support this by using the 'Basic Dynamics' Dynamic profile in the Tool Options Dialog
    > If you can't find the tool options, they can be found in 'Windows -> Dockable Dialogs -> Tool Options' in the GIMP Toolbar
