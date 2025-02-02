---
title: Windows Installation Guide
hide_from_auto_list: true
---

## Dependencies {#dependencies}

1. Install the [.NET 8 Desktop Runtime x64]({% link _sections/Framework.md %})

If you were previously using the standalone installer/updater (before v0.6), switch to the new
method for installing OpenTabletDriver below.

## Installation {#installation}

If you are upgrading from an older version of OpenTabletDriver, it is important that you do not
install it on top of the old version and instead clean up the old directory.
Alternatively you can install it to a new directory.

1. {% include latest-release.html filename=site.data.links.project.latestRelease.win-x64 %}
2. Extract the downloaded file into a folder of its own. For example:

    ```otdlog
    C:\Users\<username>\OpenTabletDriver-{{ site.data.otd-versions | last }}
    ```

    > Replace `<username>` with your username.

3. Run `{% otdexe windows-ui %}` in the extracted directory.

    > You can create a shortcut to this file, just make sure that the working directory points to the extracted directory.

## Installation of WinUSB {#winusb}

Some tablets require Zadig's WinUSB installed on a device interface to interact with the tablet
correctly. To figure out if your tablet requires WinUSB, carefully check the notes on
[the supported list of tablets here]({% link _sections/Tablets.md %}).

Some WinUSB-requiring tablets require a specific interface to be chosen.
This is also noted in the list of tablets, if relevant.

> Most tablets **DO NOT** need WinUSB! Only install WinUSB if it is explicitly listed for your tablet.
{:.alert-danger}

1. If your tablet requires WinUSB, download it
   from [here]({{ site.data.links.external.WinUSB.zadig }}).
2. Start Zadig.
3. Go to <kbd>Options</kbd> ⇒ <kbd>Show All Devices</kbd>.
4. Find your tablet with the correct interface number on the device list.
5. Click <kbd>Replace Driver</kbd>

## Post-Installation {#post-install}

Take a look at the [FAQ]({% link _wiki/FAQ/Windows.md %}) if you encounter any problems.
