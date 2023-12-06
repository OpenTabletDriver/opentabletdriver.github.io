---
title: Writing OpenTabletDriver Configurations
---

### Device Information

Generic device identification information is required for OpenTabletDriver in order for it to be able to differentiate
tablets.

|  Property Name   |   Value Type   | Description |
| :--------------: | :------------: | :---------- |
|       Name       |    `string`    | The name of the device. This is always the device manufacturer's name followed by the device's model number or product name when not applicable.

### Specifications

Tablet configuration specifications provide OpenTabletDriver with information it needs in order to correctly and
accurately handle the data the tablet device outputs.

#### Digitizer

This refers to the graphics tablet's digitizer, which provides coordinates of where the tool is positioned. This is
always required for the device to function.

|     Property Name     | Value Type |    Units     | Description |
| :-------------------: | :--------: | :----------: | :---------- |
|         Width         |  `double`  |      mm      | The physical width of the digitizer in millimeters
|        Height         |  `double`  |      mm      | The physical height of the digitizer in millimeters
| Horizontal Resolution |  `double`  | Device Units | The horizontal resolution of the digitizer in device units
|  Vertical Resolution  |  `double`  | Device Units | The vertical resolution of the digitizer in device units

#### Pen

This refers to the pen tool for the graphics tablet. It is the source of position and typically the source of pressure
data. This is almost always required.

|  Property Name  | Value Type | Description |
| :-------------: | :--------: | :---------- |
|  Max Pressure   |   `uint`   | The maximum pressure reported by the pen in device pressure units. This is used to calculate a percentage of pressure. If there are more than pens supported by this tablet, the pen with the highest pressure value is used.
|  Button Count   |   `uint`   | The amount of buttons on the pen. This does not include the eraser, if applicable. If there are more than one pens supported by this tablet, use the number of buttons on the pen with the most.

#### Auxiliary Buttons

This refers to any buttons located on the graphics tablet pad. This should only be enabled if there are any auxililary
buttons.

| Property Name | Value Type  | Description |
| :-----------: | :---------: | :---------- |
| Button Count  |   `uint`    | The amount of buttons

#### Touch

This refers to the touch digitizer, which may be built into the pen digitizer. This exists as the resolution of the
touch digitizer can be different than the pen digitizer. This should only be enabled if the graphics tablet supports
touch input.

This has the same properties as the [digitizer](#digitizer)

#### Mouse

This refers to an absolute positioning mouse tool. This should only be enabled if the graphics tablet supports a mouse.

This has the same properties as the [auxiliary buttons](#auxiliary-buttons)

### Identifiers

Device identifiers are what actually detect the tablet. Anything defined here is used in the detection process to
pinpoint devices.

|         Property Name         |         Value Type         | Description |
| :---------------------------: | :------------------------: | :---------- |
|           Vendor ID           |          `ushort`          | A [USB-IF] defined identifier that defines which vendor the device is produced by. Since this is assigned by the USB-IF it can be quite reliable for determining the manufacturer.
|          Product ID           |          `ushort`          | A vendor-defined identifier for the device. This can be used to identify a device, however this can be unreliable as it depends on the vendor defining it different for all of their devices.
|      Input Report Length      |          `ushort`          | The length of input reports from the device. This is always required as report parsers expect a specific report length.
|     Output Report Length      |          `ushort`          | The length of output reports to the device endpoint. This is not always required, however it does help make the detection more precise.
|         Report Parser         |          `string`          | The parser that will read and convert all tablet report data into a format that OpenTabletDriver understands. This is the full namespace and the class name. All supported vendor-specific report parsers can be found [here][parsers].
| Feature Initialization Report |       `List<byte[]>`       | A list of feature reports to be sent to the device to perform the device's initialization sequence.
| Output Initialization Report  |       `List<byte[]>`       | A list of output reports to be sent to the device to perform the device's initialization sequence.
|        Device Strings         | `Dictionary<byte, string>` | A list of regular expressions to be matched against specific indexes of strings contained within the device's firmware. They can be retrieved via the device string reader. This is optional, however it is commonly used to improve detection precision.
| Initialization String Indexes |          `byte[]`          | A list of indexes to be retrieved from the device as part of the device's initialization sequence. This is optional, and very infrequently used.

> Byte arrays (`byte[]`) are serialized as Base64 in JSON.NET, the library that serializes and deserializes configurations.

[USB-IF]: https://en.wikipedia.org/wiki/USB_Implementers_Forum "USB Implementers Forum"
[parsers]: https://github.com/OpenTabletDriver/OpenTabletDriver/tree/HEAD/OpenTabletDriver.Configurations/Parsers

### Attributes

Attributes are used to provide additional optional information, commonly used within utilities or tools, or within OpenTabletDriver to help with device detection.

The type of the object is `Dictionary<string, string>`, e.g. `{ "FeatureInitDelayMs": "150", "libinputoverride": "1" }`.

Some example attributes include:

|       Key Name       |     String Value     | Description |
| :------------------: | :------------------: | :---------- |
|  `libinputoverride`  |         `1`          | *(Linux only)* Whether the generic tablet interface should be ignored by [libinput] or not. Used in [udev] rule generation, using the tablets VID and PID.
|    `MacInterface`    | non-negative integer | *(MacOS only)* Specifies the USB device interface to use. For example: `0`
|    `WinInterface`    |       [00..99]       | *(Windows only)* Similar to `MacInterface`. String must have exactly two digits, (e.g. `"01"`)
|      `WinUsage`      |       [00..99]       | *(Windows only)* Specifies the HID usage collection to use. String must have exactly two digits (e.g. `"01"`)
| `FeatureInitDelayMs` |     milliseconds     | For tablets with multiple feature initialization reports (e.g. polling rate change), wait this many milliseconds between reports. This can help if later feature initialization reports are sometimes randomly not picked up by the tablet.

[libinput]: https://www.freedesktop.org/wiki/Software/libinput/ "freedesktop.org's site on libinput"
[udev]: https://wiki.debian.org/udev
