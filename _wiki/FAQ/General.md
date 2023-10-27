---
title: General FAQ
---

### Application Data Directory {#appdata}

{:.table}
| Operating System | Path |
| :--------------: | ---- |
| Windows          | `%localappdata%\OpenTabletDriver`                  |
| Linux            | `~/.config/OpenTabletDriver`                       |
| macOS            | `~/Library/Application Support/OpenTabletDriver`   |

---

### Command Line Arguments {#command-line-args}

#### UI

{:.table}
| Argument | Description |
| -------- | ----------- |
| `--minimized` or `-m` | Starts the application in a minimized state. |

#### Daemon

{:.table}
| Argument | Description |
| -------- | ----------- |
| `--appdata` or `-a` | Specifies the application data directory. |
| `--config` or `-c`  | Specifies the configurations directory. |

---

### Are Wacom Intuos tablets supported? {#wacomintuos}

Yes, most Wacom Intuos tablets are supported.

Check the back of your tablet for the model number, then check [here]({% link _sections/Tablets.md %}).

---


### Proprietary Driver Area Conversions {#area-conversion}

This can be performed from the UI or calculated manually.

#### OpenTabletDriver UI
- Right click the tablet area editor
- Click the `convert item` menu item
- Select the OEM driver and insert your area values

#### Manual Area Conversion

Check the configuration file for your tablet [here](https://github.com/OpenTabletDriver/OpenTabletDriver/tree/master/OpenTabletDriver.Configurations)
or within the driver for properly calculated digitizer dimensions in millimeters.

{:.text-muted .px-3 .mb-3}
<small>
**Note:** Huion and Gaomon areas use a "percentage area" , which uses a percentage
of the tablet's maximum area to calculate the area.\\
  You must know your tablet's digitizer dimensions in millimeters in order to properly convert these areas.\\
  This is automatically handled in the UI, for the best results it is recommended to use it for converting from these proprietary drivers.
</small>

{:.table}
| Driver | Formulas |
| :----: | -------- |
| Wacom, VEIKK | `Width = (Right - Left) / 100`<br/>`Height = (Bottom - Top) / 100`<br/>`X Offset = (Left / 100) + (Width / 2)`<br/>`Y Offset = (Top / 100) + (Height / 2)` |
| XP-Pen | `Width = W / 3.937`<br/>`Height = H / 3.937`<br/>`X Offset = (Width / 2) + (X / 3.937)`<br/>`Y Offset = (Height / 2) + (Y / 3.937)` |
| Huion, Gaomon | `Width = (Right - Left) * tabletWidth`<br/>`Height = (Bottom - Top) * tabletHeight`<br/>`X Offset = (Width / 2) + (Left * tabletWidth)`<br/>`Y Offset = (Height / 2) + (Top * tabletHeight)` |
