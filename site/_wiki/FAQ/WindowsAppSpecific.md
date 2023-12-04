---
title: Windows App-specific FAQ
---

## Games

### osu!stable {#osustable}

#### No input from my tablet is detected

Don't run osu! as admin.

#### I can't reach certain areas of osu!'s window with my tablet {#raw-input}

Set mouse sensitivity to 1.0x in osu!'s settings and disable "Map raw input to osu! window".

#### My cursor is moving faster in osu! than in other applications

See [above](#raw-input).

#### My cursor is only moving in an extremely small area on top left of osu!'s window

Do not use Windows Ink.

#### My cursor is shaky

That's perfectly normal unless it's going really crazy and teleports everywhere. In that case, see this section about resolving [EMI issues]({% link _wiki/FAQ/General.md %}#emi-interference).

If it is not an EMI issue and you still wanna remove the shakiness, try one of the many smoothing plugins that OpenTabletDriver and its community has to offer.

### Valorant

#### Valorant is not detecting input from my tablet

Use the [`VMultiMode` plugin's](https://github.com/X9VoiD/VoiDPlugins/wiki/VMultiMode) `VMulti Relative Mode` as OpenTabletDriver's output mode.

**Make sure to read the following text before running Valorant.**

Vanguard (Valorant's anti-cheat software) blocks input from certain sources. This includes `SendInput` API which OpenTabletDriver uses in its `Absolute Mode`. VMulti is a *kernel-level* driver, which means that it is not affected by Vanguard. However, there are still some restrictions:

- The first mouse input source that it detects is the only one that it allows to send input. This means that you **MUST NOT** use your mouse to open and play Valorant. Doing so leads to the tablet not working in Valorant.
- Since VMulti exists as a separate input source than those that serves the mouse AND keyboard, this means that interacting with the keyboard will also cause issues in Valorant in certain cases.
    - You won't be able to press "Left Click" while pressing any keyboard key. "Left Click" is a Vanguard-protected keybind.
    - Every time you press a keyboard key, the next two "Left Click"s will **ALWAYS** be dropped/blocked.
    - Pressing a keyboard key while holding "Left Click" will cause the "Left Click" to be dropped/blocked.

There is **NO** fix for this. All other drivers that rely on VMulti to send input are also affected without exception. This includes the original TabletDriver (Hawku, Devocub, etc.), XP-Pen, Huion, Gaomon, Veikk, etc.

As a workaround, do not use "Left Click" as your binding to "Fire" action. Instead, use an unused keyboard key then go to OpenTabletDriver and change your "Left Click" binding to that unused keyboard key.

## Art Programs

Use [Windows Ink](https://github.com/X9VoiD/VoiDPlugins/wiki/WindowsInk) plugin to enable pressure support.
OpenTabletDriver does not support the WinTab API.

### Clip Studio Paint

Clip Studio Paint should be using Windows Ink by default. If you are still experiencing lack of pen
pressure, do the following:

1. Open Clip Studio Paint
2. Go to `File > Preferences > Tablet`
3. Under `Tablet Service`, select `Tablet PC`

No need to restart the application.

### Photoshop CC

If Photoshop CC is not detecting pressure, try the following:

1. Go to `%appdata%\Adobe\Adobe Photoshop 2023\Adobe Photoshop 2023 Settings`
2. Check if there is a file called `PSUserConfig.txt`. If there is, open it. If not, create it.
3. Add the following lines to the file:

```sh
# Use Windows Ink for tablet input
UseSystemStylus 1
```

Replace `2023` with your version number if you're using a different version of Photoshop CC.

### Krita

1. Open Krita
2. Go to `Settings > Configure Krita...`
3. Go to `Tablet Settings`
4. Under Tablet Input API, select `Windows 8+ Pointer Input (Windows Ink)`
5. Click `OK`
6. Restart Krita

### GIMP

Use GIMP 2.99 to have Windows Ink support. GIMP 2.10 and below does not support Windows Ink.

### FireAlpaca

1. Open FireAlpaca
2. Go to `File > Brush Environment Settings`
3. For `Select Pen Pressure API`, select any option that includes `TabletPC`

### Paint Tool SAI

This program does not support Windows Ink. Use Paint Tool SAI 2 instead if you wish to remain using
Paint Tool SAI programs. If you have a license already for SAI 1, you may use it to upgrade to SAI
2 for free. Please refer to the [official website](https://www.systemax.jp/en/sai/devdept.html)
for more information.

### Paint Tool SAI 2

1. Open Paint Tool SAI 2
2. Go to `Other > Options`
3. Click `Pen Tablet`
4. Select `Use Windows API (For Windows Vista or later)`
5. Click `Ok`, then restart Paint Tool SAI 2

### MediBang Paint

1. Open MediBang Paint
2. Go to `File > Brush Environment Settings`
3. Enable `Validate native OS pen pressure detection`
4. Click `OK`

No need to restart the application.

### Corel Painter

1. Open Corel Painter
2. Go to `Edit > Preferences > Tablet...`
3. Click `RTS-compatible device (Real-Time Stylus)`
4. Click `OK`, then restart Corel Painter

### Rebelle

1. Open Rebelle
2. Go to `Edit > Preferences`
3. Click `Tablet`
4. Select `Windows 8+ Pointer Input` or `Windows Ink Compatible`
5. Click `OK`, then restart Rebelle

### Affinity Photo / Designer

1. Open Affinity Photo / Designer
2. Go to `Edit > Settings`
3. Click `Tools`
4. For `Tablet Input Method`, select `Windows Ink`
5. Click `OK`, then restart Affinity Photo / Designer

### ArtRage

1. Open ArtRage
2. Go to `Edit > ArtRage Preferences > Input Device`
3. Uncheck `Use WinTab`
4. Click `OK`, then restart ArtRage
