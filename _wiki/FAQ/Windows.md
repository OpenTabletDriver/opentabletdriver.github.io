---
title: Windows FAQ
---

### My tablet is not detected? {#tablet-not-detected}

Please check that your tablet is actually plugged in to your PC. Windows by default will indicate when a device is plugged in
with a sound. If you do not get this sound consider replacing the cable (make sure the cable supports both power and data transfer)

Once you are sure that your tablet is connected to your computer, ensure that your specific tablet make and model is supported by checking our list of supported tablets [here]({% link _sections/Tablets.md %}).

We currently do not support tablets that connect directly to a computer via Bluetooth, and there is only limited support for tablets that use wireless USB receivers, so please make sure your tablet is connected via cable.

#### It is a supported tablet, but still doesn't detect?

Please make sure that you have no other tablet drivers on the system.\\
To ensure your system is clean, follow the instructions for our [Tablet Driver Cleanup Utility](https://github.com/X9VoiD/TabletDriverCleanup/releases/latest), then resume here.

Please check if your tablet requires WinUSB [here]({% link _sections/Tablets.md %}) (it will say in the notes).\\
If it does, follow the [instructions]({% link _wiki/Install/Windows.md %}#winusb) and return here. Continue below for troubleshooting instructions if your tablet still isn't detected.

If you are running OpenTabletDriver.UX, navigate from the top to the Console tab, if you are running the daemon standalone, look for a log that resembles the following:

##### Tablet driver interefence

```sh
Another tablet driver found: <name>
```

If you see this log message you should follow the instructions for [TabletDriverCleanup](https://github.com/X9VoiD/TabletDriverCleanup/releases/latest) if you haven't already, making sure to say yes to everything.\\
If the log entry is still there after following the instructions and restarting OTD, try joining our support [Discord]({% link _sections/Discord.md %}) for further help.

##### Invalid WinUSB driver installation state

```sh
Failed to open file handle to WinUSB interface
SafeHandle cannot be null. (Parameter 'pHandle')
```

This is usually resolved when you restart your PC.

If nothing above applies, remove `%localappdata%/OpenTabletDriver` or the contents of the `userdata` folder next to the binaries (if applicable).
If you still need more help after this, join our Discord and give us a shout in the `#support-windows` channel, mentioning what you have tried.

#### It is not a supported tablet, what can I do about that?<

If you want to add support for your tablet on your own, feel free to look at a similar configuration on our GitHub and our configuration documentation.
If you would like help with supporting your tablet, or would prefer us to do it, join our [Discord]({% link _sections/Discord.md %}) and create a post in `#config-creation` or a support channel.

---

### My tablet is detected, but my settings don't work. {#tablet-not-functioning-correctly}

If your area/bindings are not working correctly despite detection, try following our troubleshooting steps below.

Make sure that you have saved your settings by pressing the save button in the bottom right of the OpenTabletDriver interface.

If you have done the above and your settings still do not apply then make sure that you don't have other drivers installed on your computer,
you can remove these by running and following the instructions for [TabletDriverCleanup](https://github.com/X9VoiD/TabletDriverCleanup/releases/latest), come back here.

If your cursor is teleporting you usually have another driver installed or you have broken settings, you can resolve the former by following the former with
[TabletDriverCleanup](https://github.com/X9VoiD/TabletDriverCleanup/releases/latest) and you can solve the latter with `file > reset to defaults` and clicking save.

If the issue is still unresolved after trying the instructions above, please join our [Discord]({% link _sections/Discord.md %}) for extra assistance.

---

### My cursor doesn't function correctly in osu! {#osu-broken-input}

Either disable `Raw Input` in the game settings entirely or disable `Map raw input to osu! window`
in the ingame settings and make sure that sensitivity is set to 1x.

{:.text-muted}
Note: OpenTabletDriver has since v0.4.0 supported Raw Input as it uses the Windows SendInput API to position the cursor.
Therefore, it is not necessary to disable raw input itself, but it provides no merit on tablets to have it enabled.

---

### How do I get pressure support? {#win-ink}

You can get Windows Ink pressure support with the Windows Ink plugin that is accessible through the Plugin Manager. To use it, follow the instructions below.
 - Install [VMulti Driver](https://github.com/X9VoiD/vmulti-bin/releases/latest) (This is NOT VMultiMode)
 - Follow the instructions from the [WindowsInk wiki](https://github.com/X9VoiD/VoiDPlugins/wiki/WindowsInk)
 - Make sure that the application you are trying drawing in is set to WindowsInk/Windows 8+ Mode and the brush you are using has pressure support!

If you already have a different installation of VMulti it is recommended that you first run
[TabletDriverCleanup](https://github.com/X9VoiD/TabletDriverCleanup/releases/latest) to avoid any potential conflicts.

{:.text-muted}
Note: Recently, a change in Windows made it so Windows Ink's and normal Mouse's cursor position is handled separately.\\
This makes it so your cursor will appear to "jump" when switching from tablet to mouse while using Windows Ink output modes.
This is not a bug of OpenTabletDriver but rather one of Windows.

---

### What is convert_to_portable.bat? {#userdata}
This file moves OpenTabletDriver's settings to a folder called *userdata* next to OpenTabletDriver itself
rather than being stored in *%localappdata%\OpenTabletDriver*.

This allows OpenTabletDriver to be completely portable, all in one folder.

---

### It says it fails to connect to the daemon? {#connecting-to-daemon}
This can be caused by a few different problems.
Primarily, this will result from incorrectly following the [installation guide]({% link _wiki/Install/Windows.md %}) on installation.

If you are sure that you have followed the installation guide correctly, or this issue just began occurring after an update to OTD,
then it is likely that you have broken settings or outdated plugins installed. You can remedy this with the below.
 - Press <kbd>Win</kbd> + <kbd>R</kbd> and type in `%localappdata%\OpenTabletDriver`
 - Delete or move the `settings.json` file from inside this folder.
 - If this persists after also remove the `Plugins` folder.

If you have a `userdata` folder next to the binaries of OpenTabletDriver, you will need to remove the files above from that folder instead.

If you still can't get it working after the solutions above please join our [Discord]({% link _sections/Discord.md %}).
It might be a completely different issue!

---

### How do I make OTD start automatically when I boot my PC? {#startup}

Starting OpenTabletDriver at login can be performed quite easily. This can be done for nearly any
program, although there may be better ways to do it for those programs.

 - Right click `OpenTabletDriver.UX.Wpf.exe` and create a shortcut.
 - Press <kbd>Win</kbd> + <kbd>R</kbd> and type in `shell:startup`
 - Move the shortcut into the folder that opened.

Starting OpenTabletDriver minimised can also be done by changing the properties of a shortcut.
To do this, right click the OpenTabletDriver shortcut, go to properties > run > minimised.

---

### Plugin Manager won't open/I get a warning on startup? {#administrator}

When Starting OpenTabletDriver you may get an error warning you about Administrator Permissions.
OpenTabletDriver should NEVER be run as Administrator or with Administrator permissions.
This causes the plugin manager, FAQ page, and Tablet debugger to not work, and can interfere with several other features.

The following instructions should fix your issue under normal circumstances, but if you're using the (disabled in a fresh Windows install by default) account called "Administrator",
usually because you're using a "custom" iso (unofficial version of Windows, also sometimes referred to as a "debloated Windows") install,
these instructions will not work for you.

We generally recommend against using altered or 3rd party versions of Windows,
as OTD is likely to not be the only software adversely affected by the changes these custom ISOs make.

 - Press the Windows key and search` User Account Control`.
 - Move the slider to one of the top 2 options.
 - Click OK, then restart your computer.

---

### Why is my interface completely blank? {#rtss}

If you are experiencing random crashes with no warning, or the interface is completely blank and/or not accepting input, and you have RiverTuner Statistics Server
installed, it may be hooking into OpenTabletDriver and preventing the UX from functioning correctly.

If you use this application, make sure it doesn't hook onto OpenTabletDriver by blacklisting it in RiverTuner's settings.

 - Open RivaTuner Statistics Server.
 - Click on Add button found in the bottom left corner.
 - Locate OpenTabletDriver.UX.Wpf.exe on your computer then select it. Refer [here]({% link _wiki/FAQ/General.md %}#appdata) for more information.
 - Click on Application Detection Level then select "None".

---

### Cursor doesn't move with Valorant open? {#vmulti}

Vanguard (Valorants anticheat) requires a workaround to play Valorant with a tablet. As it requires Kernel level input
you can use VMulti to mitigate some of the restrictions that Vanguard uses to stop tablet use. However, there will still be some restrcitions due
to you not playing with a physical mouse.

- Install [VMulti Driver](https://github.com/X9VoiD/vmulti-bin/releases/latest)
- Install and setup the [VMultiMode](https://github.com/X9VoiD/VoiDPlugins/wiki/VMultiMode) plugin.
- Run Valorant by **tapping with your tablet** (Important due to Valorant only using the first "mouse" input)
- **Do not** move your mouse while valorant is still loading (this will make valorant use the mouse over the tablet.)

<u>Vanguard Quirks:</u>

As VMulti is considered a separate input source from an actual physical mouse, Vanguard imposes several limitations to it

 - You won't be able to press left click while pressing a non-modifier keyboard key (for ex. WASD) and shift, we will call these keys from here onward as *protected keys.*
 - Every time you press a protected key, the next two left clicks will *always* be dropped.
 - If left click is held first and then a protected key is pressed, the left click will *sometimes* be dropped.

There is **no** fix this, as even Logitech G Hub, Razer Synapse, HawkuTD, DevocubTD, and even XP-Pen, Huion, Gaomon, Veikk drivers are affected without exceptions.
**As long as the input source is not a real physical mouse, Vanguard will impose such quirks _intentionally._**

