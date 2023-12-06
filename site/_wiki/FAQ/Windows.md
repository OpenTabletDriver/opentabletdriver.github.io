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

To ensure your system is clean, follow the instructions in [TabletDriverCleanup]({{ site.data.links.external.TabletDriverCleanup.latest }}), then resume here.

Please check if your tablet requires WinUSB [here]({% link _sections/Tablets.md %}) (it will say in the Notes column). If it does, follow the [instructions]({% link _wiki/Install/Windows.md %}#winusb) and return here. Continue below for troubleshooting instructions if your tablet still isn't detected.

#### Common Problems

[Check logs]({% link _wiki/Documentation/Logs.md %}) for any errors or warnings. If you find any, try finding for a match and its accompanying solution below:

##### Tablet driver interference

*Symptoms*:

```otdlog
Another tablet driver found: <driver>
```

*Solution*:

- Follow the instructions in [TabletDriverCleanup]({{ site.data.links.external.TabletDriverCleanup.latest }}), and make sure to type <kbd>Y</kbd> for every driver found by the utility. Then, restart OTD.
- If the log entry is still present, try joining our support [Discord]({{ site.data.links.project.DiscordInvite }}) and asking for help in the #support-windows channel.

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

This is most likely due to some firmware variation. Try joining our support [Discord]({{ site.data.links.project.DiscordInvite }}) and asking for help in one of the #support channels, or submit a [bug report]({{ site.data.links.project.OpenNewIssue }}) in GitHub.

#### No pressure {#win-ink}

OpenTabletDriver has no built-in support for pressure on Windows due to external dependencies that cannot be bundled with the driver. Follow the instructions below to enable pressure support:

- Install [VMulti Driver]({{ site.data.links.external.VMultiDriver.latest }}).
- Install and follow instructions from [WindowsInk wiki]({{ site.data.links.external.WindowsInkPlugin.wiki }}).
- Configure your application to use Windows Ink API. See [here]({% link _wiki/FAQ/WindowsAppSpecific.md %}#art-programs) for app-specific configuration instructions.

### How do I make a portable install? {#userdata}

By having a folder called `userdata` next to the OpenTabletDriver files, anything related to
OpenTabletDriver is instead stored in this folder.

Having a portable install is useful for testing new releases without them affecting your existing
settings and plugins, or for having the driver available with your preferred settings and
plugins you can send to friends, or bring with you.

**It is particularly important to use this feature when testing pre-releases, as cross-version
configuration compatibility is not guaranteed.**

The default location is described in the
General FAQ's [appdata section]({% link _wiki/FAQ/General.md %}#appdata)

If you wish to convert your existing install to a portable install, the `convert_to_portable.bat` script moves OpenTabletDriver's settings to the `userdata` folder.

### How to fix "Connecting to daemon has timed out" error? {#no-daemon}

Check if `{% otdexe windows-daemon %}` and `{% otdexe windows-ui %}` is in the same folder. This should be the case if the [Installation]({% link _wiki/Install/Windows.md %}) instructions were followed correctly.

If both files are in the same folder, the daemon may have crashed during launch.

- Press <kbd>Win</kbd> + <kbd>R</kbd> to open the Run dialog.
- Type `%localappdata%\OpenTabletDriver` then press <kbd>Enter</kbd>.
- Delete or rename `settings.json` to `settings.json.bak`.
- If problem persists, try also renaming `Plugins` folder to `Plugins.bak`.

> If you converted OpenTabletDriver to a portable install, go inside the `userdata` folder instead.

### How to autostart OpenTabletDriver on boot? {#startup}

The following is just one of the multiple ways that you may launch OTD at startup.

- Right click `{% otdexe windows-ui %}` and select `Create shortcut`.
- Press <kbd>Win</kbd> + <kbd>R</kbd> to open the Run dialog.
- Type `shell:startup` then press <kbd>Enter</kbd>.
- Move the shortcut you created earlier to the folder that opened.

To start OpenTabletDriver minimised, continue below:

- Right click the shortcut and select `Properties`.
- In the `Run` dropdown, select `Minimized`.

### I get a warning about not running it as Administrator on startup? {#administrator}

OpenTabletDriver should *NEVER* be run as Administrator, and there is never a need to run as Administrator.

Follow the [instructions]({{ site.data.links.external.Microsoft.AdjustUAC }}) provided by Windows and adjust protection level to at least:

- Notify me when apps try to make changes to my computer.

Then restart your computer to apply.

If you are still getting the warning, make sure that you are not using the account called `Administrator`. This is *NEVER* meant to be used as a normal account for daily use. Create a new normal account with administrator privileges and use that instead.

> We are aware that most custom ISOs use the Administrator account. Due to the nature of custom ISOs, we *do not* provide official support to them.

If you need to interact with a program that runs with Administrator privileges, use [VMultiMode]({{ site.data.links.external.VMultiModePlugin.wiki }}).

### Plugin manager is not showing up {#plugin-manager-broken}

It is likely because you are running OpenTabletDriver with the Administrator account. See [above](#administrator).

### OpenTabletDriver is completely blank {#rtss}

If you are experiencing random crashes with no warning, or the interface is completely blank and/or not accepting input, and you have RivaTuner Statistics Server installed, it may be hooking into OpenTabletDriver and therefore prevents {% otdexe windows-ui %} from functioning correctly.

If you are using RivaTuner Statistics, make sure it doesn't hook onto OpenTabletDriver by blacklisting it in its settings.

- Open RivaTuner Statistics Server.
- Click on the Add button, found in the bottom left corner.
- Locate `{% otdexe windows-ui %}` on your computer, then select it.
  > Refer [here]({% link _wiki/FAQ/General.md %}#appdata) for more information.
- Click on "Application Detection Level" then select "None".

### Still have problems? {#discord}

If you are still encountering problems with OpenTabletDriver, it will be easier to help you over in our [Discord]({{ site.data.links.project.DiscordInvite }}) server. We will guide you in doing certain debugging steps and will give you different instructions to help resolve your problem.
