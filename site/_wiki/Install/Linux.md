---
title: Linux Installation Guide
hide_from_auto_list: true
---

### Ubuntu / Debian {#debian}

1. Download the [latest release]({{ site.data.links.project.latestRelease.deb }}) <small class="text-muted">(OpenTabletDriver.deb)</small>
2. Run the following commands in a terminal

    ```bash
    # Update the package list
    sudo apt update

    # This will install the package
    sudo apt install ./OpenTabletDriver.deb
    ```

    > This assumes that you are in the directory in which you downloaded OpenTabletDriver to.
3. Refer to [this section]({% link _wiki/FAQ/Linux.md %}#autostart) for instructions on how to auto-start OpenTabletDriver on boot.

If you have the Microsoft dotnet repository installed you will have to either make sure you are not using any packages from that repository or use everything dotnet based off that. Mixing packages from different repositories will cause `libhostfxr` issues.

See solutions from Microsoft [here]({{ site.data.links.external.Microsoft.DotnetLinuxPackageMixup }})and remove the Microsoft repositories and packages if you're experiencing `libhostfxr` issues.

### Fedora {#rpm}

1. Download the [latest release]({{ site.data.links.project.latestRelease.rpm }}) <small class="text-muted">(OpenTabletDriver.rpm)</small>
2. Run the following commands in a terminal

    ```bash
    # This will install the package
    sudo dnf install ./OpenTabletDriver.rpm
    ```

    > This assumes that you are in the directory in which you downloaded OpenTabletDriver to.
3. Refer to [this section]({% link _wiki/FAQ/Linux.md %}#autostart) for instructions on how to auto-start OpenTabletDriver on boot.

### Arch Linux {#arch}

You can install OpenTabletDriver from the AUR. There are two ways to do this.

- via [AUR helper](#aur-helper-method)
- manually via [makepkg](#manual-makepkg-method)

Then refer to [this section]({% link _wiki/FAQ/Linux.md %}#autostart) for instructions on how to auto-start OpenTabletDriver on boot.

#### AUR helper method {#aur-helper-method}

1. Use an [AUR helper](https://wiki.archlinux.org/title/AUR_helpers) to install the `opentabletdriver` AUR package.
2. Run the following commands in a terminal

    ```sh
    # Regenerate initramfs
    sudo mkinitcpio -P
    # Unload kernel modules
    sudo rmmod wacom
    sudo rmmod hid_uclogic
    ```

#### `makepkg` method {#manual-makepkg-method}

1. Run the following commands

    ```sh
    # Downloads the pkgbuild from the AUR.
    git clone https://aur.archlinux.org/opentabletdriver.git
    # Changes into the correct directory and installs OpenTabletDriver
    cd opentabletdriver && makepkg -si
    # Clean up leftovers
    cd ..
    rm -rf opentabletdriver
    # Regenerate initramfs
    sudo mkinitcpio -P
    # Unload kernel modules
    sudo rmmod wacom
    sudo rmmod hid_uclogic
    ```

### Gentoo {#gentoo}

1. Add Guru overlay

    > This is only required if you don't already have the Guru overlay configured

    ```bash
    # Enable guru repository
    sudo eselect repository enable guru
    sudo emerge --sync guru
    ```

2. Edit `/etc/portage/package.accept_keywords` and add this line

    ```conf
    x11-drivers/OpenTabletDriver-bin ~amd64
    ```

3. Run the following command

    ```bash
    # Install the OpenTabletDriver package
    sudo emerge OpenTabletDriver-bin
    ```

4. Refer to [this section]({% link _wiki/FAQ/Linux.md %}#autostart) for instructions on how to auto-start OpenTabletDriver on boot.

### NixOS {#nixos}

1. Edit `/etc/nixos/configuration.nix` and add this in your configuration

    > More configuration options can be found [here](https://search.nixos.org/options?query=opentabletdriver)

    ```nix
    # Enable OpenTabletDriver
    hardware.opentabletdriver.enable = true;
    ```

### Post-Installation {#post-install}

Take a look at the [FAQ]({% link _wiki/FAQ/Linux.md %}) if you encounter any problems.
