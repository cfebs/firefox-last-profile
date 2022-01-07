# firefox-last-profile

Tooling to help firefox achieve chrome's "open-link-in-last-used-profile" behavior.

## Install

```
make install
```

> Use `PREFIX=.local make install` and check `./.local` to preview what's getting copied

## Contents

* Firefox launcher bins to start firefox with `firefox -P ${PROFILE}`
* User systemd unit to spy on X11 window changes and find the firefox profile used in that window
    * Writes a state file to `$HOME/.local/var/last-firefox-profile/profile`
* Exe to start firefox with the profile found in that file
    * A companion `firefox-last-profile.desktop` entry so it can be used with xdg

## Constrains

* `X11` only
* Janky python3 for the spy
* Relies on Firefox launching with the `firefox -P ${PROFILE}` cmdline
