---
title: Windows FAQ
hide_from_auto_list: true
---

- **It is recommended that you check [General FAQ]({% link _wiki/FAQ/General.md %})
first before continuing.**
- Also check out [Windows App Specific FAQ]({% link _wiki/FAQ/WindowsAppSpecific.md %}) for app-specific instructions.

### My tablet is supported but not detected? {#troubleshooting}

Read [General FAQ]({% link _wiki/FAQ/General.md %}#tablet-not-detected) first before continuing below if you haven't already.

#### Driver Cleanup

If your tablet is connected properly and is supported but is still not detected, please make sure that you have no other tablet drivers on the system.

To ensure your system is clean, follow the instructions in [TabletDriverCleanup](https://github.com/X9VoiD/TabletDriverCleanup/releases/latest), then resume here.

Please check if your tablet requires WinUSB [here]({% link _sections/Tablets.md %}) (it will say in the Notes column). If it does, follow the [instructions]({% link _wiki/Install/Windows.md %}#winusb) and return here. Continue below for troubleshooting instructions if your tablet still isn't detected.

#### Common Problems

[Check logs]({% link _wiki/Documentation/Logs.md %}) for any errors or warnings. If you find any, try finding for a match and its accompanying solution below:

##### Tablet driver interference

*Symptoms*:

```otdlog
Another tablet driver found: <driver>
```

*Solution*:

- Follow the instructions in [TabletDriverCleanup](https://github.com/X9VoiD/TabletDriverCleanup/releases/latest), and make sure to type <kbd>Y</kbd> for every driver found by the utility. Then, restart OTD.
- If the log entry is still present, try joining our support [Discord]({{ site.discord_invite_url }}) and asking for help in one of the #support channels.

##### Invalid WinUSB driver state

*Symptoms*:

```otdlog
Failed to open file handle to WinUSB interface
SafeHandle cannot be null. (Parameter 'pHandle')
```

*Solution*:

- Restart your computer.

### Tablet is detected but not working? {#tablet-not-functioning-correctly}

#### No input

This is most likely due to some firmware variation. Try joining our support [Discord]({{ site.discord_invite_url }}) and asking for help in one of the #support channels, or submit a [bug report](https://github.com/OpenTabletDriver/OpenTabletDriver/issues/new) in Github.

#### No pressure {#win-ink}

OpenTabletDriver has no built-in support for pressure on Windows due to external dependencies that cannot be bundled with the driver. Follow the instructions below to enable pressure support:

- Install [VMulti Driver](https://github.com/X9VoiD/vmulti-bin/releases/latest).
- Install and follow instructions from [WindowsInk plugin wiki](https://github.com/X9VoiD/VoiDPlugins/wiki/WindowsInk).
- Configure your application to use Windows Ink API. See [here]({% link _wiki/FAQ/WindowsAppSpecific.md %}#art-programs) for app-specific configuration instructions.

### What is convert_to_portable.bat? {#userdata}

This file moves OpenTabletDriver's settings to a folder called `userdata` next to OpenTabletDriver itself rather than being stored in `%localappdata%\OpenTabletDriver`.

This allows OpenTabletDriver to be completely portable, all in one folder.

### How to fix "Connecting to daemon has timed out" error? {#no-daemon}

Check if `OpenTabletDriver.Daemon` and `OpenTabletDriver.UX.Wpf` is in the same folder. This should be the case if the [Installation]({% link _wiki/Install/Windows.md %}) instructions were followed correctly.

If both files are in the same folder, the daemon may have crashed during launch.

- Press <kbd>Win</kbd> + <kbd>R</kbd> to open the Run dialog.
- Type `%localappdata%\OpenTabletDriver` then press <kbd>Enter</kbd>.
- Delete or rename `settings.json` to `settings.json.bak`.
- If problem persists, try also renaming `Plugins` folder to `Plugins.bak`.

> If you converted OpenTabletDriver to a portable install, go inside the `userdata` folder instead.

### How to autostart OpenTabletDriver on boot? {#startup}

The following is just one of the multiple ways that you may launch OTD at startup.

- Right click `OpenTabletDriver.UX.Wpf.exe` and select `Create shortcut`.
- Press <kbd>Win</kbd> + <kbd>R</kbd> to open the Run dialog.
- Type `shell:startup` then press <kbd>Enter</kbd>.
- Move the shortcut you created earlier to the folder that opened.

To start OpenTabletDriver minimised, continue below:

- Right click the shortcut and select `Properties`.
- In the `Run` dropdown, select `Minimized`.

### I get a warning about not running it as Administrator on startup? {#administrator}

OpenTabletDriver should *NEVER* be run as Administrator, and there is never a need to run as Administrator.

Follow the [instructions](https://learn.microsoft.com/en-us/mem/intune/user-help/you-need-to-enable-uac-windows#adjust-protection-level) provided by Windows and adjust protection level to at least:

- Notify me when apps try to make changes to my computer.

Then restart your computer to apply.

If you are still getting the warning, make sure that you are not using the account called `Administrator`. This is *NEVER* meant to be used as a normal account for daily use. Create a new normal account with administrator privileges and use that instead.

> We are aware that most custom ISOs use the Administrator account. Due to the nature of custom ISOs, we *do not* provide official support to them.

If you need to interact with a program that runs with Administrator privileges, use [VMultiMode](https://github.com/X9VoiD/VoiDPlugins/wiki/VMultiMode).

### Plugin manager is not showing up {#plugin-manager-broken}

It is likely because you are running OpenTabletDriver with the Administrator account. See [above](#administrator).

### OpenTabletDriver is completely blank {#rtss}

If you are experiencing random crashes with no warning, or the interface is completely blank and/or not accepting input, and you have RivaTuner Statistics Server installed, it may be hooking into OpenTabletDriver and prevents OpenTabletDriver.UX.Wpf from functioning correctly.

If you are using RivaTuner Statistics, make sure it doesn't hook onto OpenTabletDriver by blacklisting it in its settings.

- Open RivaTuner Statistics Server.
- Click on Add button found in the bottom left corner.
- Locate OpenTabletDriver.UX.Wpf.exe on your computer then select it. Refer [here]({% link _wiki/FAQ/General.md %}#appdata) for more information.
- Click on "Application Detection Level" then select "None".

### Still have problems? {#discord}

If you are still encountering problems with OpenTabletDriver, it will be easier to help you over in our [Discord]({{ site.discord_invite_url }}) server. We will guide you in doing certain debugging steps and will give you different instructions to help resolve your problem.
