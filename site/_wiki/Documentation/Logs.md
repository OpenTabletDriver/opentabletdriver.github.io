---
title: Logs
---

### GUI

To view logs, click on the `Console` tab. Optionally, change filter from `Information` to `Debug` for more detailed logs.

To export logs, click `Help` -> `Export diagnostics...` in the top menu bar.

Sometimes, the OpenTabletDriver daemon can crash hard enough that the errors can't be
sent to the GUI. In this case, you can find a
partial log in the [Exception Log Location](#daemon-log).

### Daemon

The output from daemon is the log.

On Linux when running daemon via systemd service, the log for the daemon is recorded by systemd.
To view that log, run the following command as your user:

```bash
journalctl --user-unit opentabletdriver.service
```

#### Exception Log Location {#daemon-log}

If the daemon crashes from an "unrecoverable" exception, the `daemon.log` file will
include a stack trace defining where the error happened, which is useful for debugging.

The `daemon.log` file is in the application data folder, located here:

{% include appdata-location.md %}

> For more details on what else is contained in OpenTabletDriver's application data,
  see [here]({% link _wiki/FAQ/General.md %}#appdata)
