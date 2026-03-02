---
title: Linux Installation Guide
hide_from_auto_list: true
---

{% assign latest_otd_version = site.data.otd-versions | last %}

## Ubuntu / Debian {#debian}

{% assign deb_filename = site.data.links.project.latestRelease.deb | replace: '{{VERSION}}', latest_otd_version %}

1. {% include latest-release.html filename=deb_filename %}
2. Run the following commands in a terminal

    ```bash
    # Update the package list
    sudo apt update

    # Install the package
    sudo apt install ./{{ deb_filename }}
    ```

    > This assumes that you are in the directory in which you downloaded OpenTabletDriver to.

3. Refer to [this section]({% link _wiki/FAQ/Linux.md %}#autostart) for instructions on how to auto-start OpenTabletDriver on boot.

If you have the Microsoft dotnet repository installed you will have to either make sure you are not using any packages from that repository or use everything dotnet based off that. Mixing packages from different repositories will cause `libhostfxr` issues.

If you're experiencing `libhostfxr` issues, please see the solutions from Microsoft [here]({{ site.data.links.external.Microsoft.DotnetLinuxPackageMixup }}).

## RPM-based distributions {#rpm}

### Fedora (Upstream package) {#fedora}

{% assign rpm_filename = site.data.links.project.latestRelease.rpm | replace: '{{VERSION}}', latest_otd_version %}

1. {% include latest-release.html filename=rpm_filename %}
2. Install the package with the following command:

    ```bash
    sudo dnf install ./{{ rpm_filename }}
    ```

    > This assumes that you are in the directory in which you downloaded OpenTabletDriver to.

3. Update your initramfs:

    ```bash
    sudo dracut --regenerate-all --force
    ```

4. Refer to [this section]({% link _wiki/FAQ/Linux.md %}#autostart) for instructions on how to auto-start OpenTabletDriver on boot.

### Fedora (Terra) {#terra}

[Terra]({{ site.data.links.external.Terra.website }}) also provides RPM builds for Fedora, Ultramarine and RHEL 10-based distributions.

1. Add the Terra repository

    ```bash
    sudo dnf install --repofrompath 'terra,https://repos.fyralabs.com/terra$releasever' --setopt='terra.gpgkey=https://repos.fyralabs.com/terra$releasever/key.asc' terra-release
    ```

2. Install OpenTabletDriver

    ```bash
    sudo dnf install opentabletdriver
    ```

3. Refer to [this section]({% link _wiki/FAQ/Linux.md %}#autostart) for instructions on how to auto-start OpenTabletDriver on boot.

### openSUSE {#opensuse}

1. {% include latest-release.html filename=site.data.links.project.latestRelease.rpm %}
2. Run commands from [this guide]({{ site.data.links.external.Microsoft.AddMicrosoftRepoOpenSUSE }}) to add the Microsoft package repository.

    > You don't need to install .NET runtime at this point as zypper will install it as a dependency of OpenTabletDriver.

3. Run the following commands in a terminal

    ```bash
    # Update the package list
    sudo zypper refresh

    # Install the package
    sudo zypper --no-gpg-checks install ./OpenTabletDriver.rpm
    ```

    > This assumes that you are in the directory in which you downloaded OpenTabletDriver to.

4. Refer to [this section]({% link _wiki/FAQ/Linux.md %}#autostart) for instructions on how to auto-start OpenTabletDriver on boot.

## EndeavoursOS {#endeavouros}

While EndeavourOS is based on Arch Linux, it uses a different initramfs
generator compared to standard Arch Linux, which means the post-install setup is different.

1. Install the `opentabletdriver` AUR package with either the GUI package utility, Pamac,
   or the command-line utility, `yay`

    ```sh
    yay -S opentabletdriver
    ```

2. Then, run the following commands in a terminal

{% include wiki/arch-install-steps.md ramdisk_update_command="dracut-rebuild" %}

Then refer to [this section]({% link _wiki/FAQ/Linux.md %}#autostart) for instructions on how to auto-start OpenTabletDriver on boot.

## Arch Linux {#arch}

You can install OpenTabletDriver from the AUR. There are two ways to do this.

- via [AUR helper](#aur-helper-method)
- manually via [makepkg](#manual-makepkg-method)

Then refer to [this section]({% link _wiki/FAQ/Linux.md %}#autostart) for instructions on how to auto-start OpenTabletDriver on boot.

> If you are using a ramdisk environment that isn't `mkinitcpio`, consult its documentation
  for how to regenerate or rebuild your existing ramdisk images.
  {:.alert-primary}

### AUR helper method {#aur-helper-method}

1. Use an [AUR helper](https://wiki.archlinux.org/title/AUR_helpers) to install the `opentabletdriver` AUR package.
2. Run the following commands in a terminal

{% include wiki/arch-install-steps.md %}

### `makepkg` method {#manual-makepkg-method}

1. Run the following commands in a terminal

{% include wiki/arch-install-steps.md makepkg=true %}

## Gentoo {#gentoo}

1. Add Guru overlay

    > This is only required if you don't already have the Guru overlay configured

    ```bash
    # Enable guru repository
    sudo eselect repository enable guru
    sudo emerge --sync guru
    ```

2. Edit `/etc/portage/package.accept_keywords` and add this line

    ```conf
    x11-drivers/OpenTabletDriver ~amd64
    ```

3. Install the package with the following command

    ```bash
    sudo emerge OpenTabletDriver
    ```

4. Refer to [this section]({% link _wiki/FAQ/Linux.md %}#autostart) for instructions on how to auto-start OpenTabletDriver on boot.

## NixOS {#nixos}

1. Edit `/etc/nixos/configuration.nix` and add this in your configuration

    ```nix
    # Enable OpenTabletDriver
    hardware.opentabletdriver.enable = true;
    ```

    > More configuration options can be found [here][NixOS Package Options].
    {:.alert-primary}

[NixOS Package Options]: https://search.nixos.org/options?query=opentabletdriver

## Bazzite {#bazzite}

Bazzite is based on Fedora Atomic. We recommend using `ujust` to install OpenTabletDriver:

```sh
ujust install-opentabletdriver
```

## Post-Installation {#post-install}

Take a look at the [FAQ]({% link _wiki/FAQ/Linux.md %}) if you encounter any problems.
