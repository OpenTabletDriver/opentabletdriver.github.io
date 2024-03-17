---
title: Logs
---

## GUI

To view the current logs, click on the <kbd>Console</kbd> tab. Optionally, change filter from <kbd>Information</kbd> to <kbd>Debug</kbd> for more detailed logs.

You can also find previous logs in the `Logs/` folder of the application data location.
See more in the [Daemon log](#daemon-log) section.

To export logs, click <kbd>Help</kbd> ⇒ <kbd>Export diagnostics</kbd> in the top menu bar.

## Daemon

The output from daemon is logged to the `Logs/` folder.

On Linux when running daemon via systemd service, the log for the daemon is also recorded by systemd.
To view that log, run the following command as your user:

```bash
journalctl --user-unit opentabletdriver.service
```

### Daemon Log Location {#daemon-log}

If the daemon crashes from an "unrecoverable" exception, the error is appended to the log file.
It contains a stack trace defining where the error happened, which is useful for debugging.

Up to 20 log files will be stored in the `Logs/` folder, using the date of when the daemon started as a file name.

The log files are formatted in an almost-JSON format. It is likely they are missing the array end (`]`) which
some JSON parsers do not like. However, the format remains mostly human-readable.

The `Logs/` folder is in the application data folder, located here:

{% include appdata-location.md %}

> For more details on what else is contained in OpenTabletDriver's application data,
  see [here]({% link _wiki/FAQ/General.md %}#appdata)
  {:.alert-primary}
