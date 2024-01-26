{% assign ramdiskUpdateCommand = include.ramdisk_update_command | default: "mkinitcpio -P" %}
{% assign elevateCommand = include.elevate_command | default: "sudo" %}
{% assign includeMakepkgSteps = include.makepkg | default: false %}

    ```sh
    {% if includeMakepkgSteps -%}
        {% include wiki/arch-makepkg-steps.txt %}
    {%- endif -%}
    {% include wiki/arch-regen-commands.txt -%}
    ```
