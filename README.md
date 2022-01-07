# firefox-last-profile

Tooling to help firefox achieve chrome's "open-link-in-last-used-profile" behavior.

## Install

```
make install
```

> Use `PREFIX=.local make install` and check `./.local` to preview what's getting copied

## Start

Start user unit, set default browser to the new .desktop entry

```
make enable
```

Check output from the service with `journalctl --user -feu firefox-track-focus.service`

## Contents

* Firefox launcher bins to start firefox with `firefox -P ${PROFILE}`
* User systemd unit to spy on X11 window changes and find the firefox profile used in that window
    * Writes a state file to `$HOME/.local/var/last-firefox-profile/profile`
* Exe to start firefox with the profile found in that file
    * A companion `firefox-last-profile.desktop` entry so it can be used with xdg

```
❯ make clean && PREFIX=.local make install
mkdir -p .local
install -D -t .local/bin ./local/bin/firefox-last-profile ./local/bin/dmenu-firefox-profile ./local/bin/rofi-firefox-profile ./local/bin/firefox-track-focus
install -m644 -D -t .local/share/applications ./local/share/applications/firefox-last-profile.desktop
install -m644 -D -t .local/share/systemd/user ./local/share/systemd/user/firefox-track-focus.service

❯ tree .local
.local
├── bin
│   ├── dmenu-firefox-profile
│   ├── firefox-last-profile
│   ├── firefox-track-focus
│   └── rofi-firefox-profile
└── share
    ├── applications
    │   └── firefox-last-profile.desktop
    └── systemd
        └── user
            └── firefox-track-focus.service

5 directories, 6 files
```


## Notes

The big one:
* Relies on Firefox launching with the `firefox -P ${PROFILE}` cmdline. Firefox does not do this
by default via `about:profiles` or the `firefox --ProfileManager` manager window.

* `X11` and `systemd` only
* Janky python3
