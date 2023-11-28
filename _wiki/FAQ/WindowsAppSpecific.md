---
title: Windows App-specific FAQ
---

### osu!stable {#osustable}

#### No input from my tablet is detected

Don't run osu! as admin.

#### I can't reach certain areas of osu!'s window with my tablet {#raw-input}

Set mouse sensitivity to 1.0x in osu!'s settings and disable "Map raw input to osu! window".

#### My cursor is moving faster in osu! than in other applications

See [above](#raw-input).

#### My cursor is only moving in an extremely small area on top left of osu!'s window

Do not use Windows Ink.

#### My cursor is shaky!

That's perfectly normal unless it's going really crazy and teleports everywhere. In that case, see this section about resolving [EMI issues]({% link _wiki/FAQ/General.md %}#emi-interference).

If it is not an EMI issue and you still wanna remove the shakiness, try one of the many smoothing plugins that OpenTabletDriver and its community has to offer.

---

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
