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
