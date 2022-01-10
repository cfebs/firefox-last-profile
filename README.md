# firefox-last-profile

Tooling to help firefox achieve chrome's "open-link-in-last-used-profile" behavior.

## Install

```
make install
```

Make sure `~/.local/bin` and `/usr/local/bin` are added to your `PATH`

You will be prompted for sudo password to install bins.

> Use `BIN_PREFIX=.local PREFIX=.local make install` and check `./.local` to preview what's getting copied

## Start

```
make enable
```

A phony task that enables and starts the user unit and sets the default browser to the new
.desktop entry.

> Check status of the service with `systemctl --user status firefox-track-focus.service`

> Check logs of the service with `journalctl --user -feu firefox-track-focus.service`

## Use

Quit your firefoxes and start them again with `firefox -P ${PROFILENAME}`

`make install` places the following in `/usr/local/bin`:
* `dmenu-firefox-profile`
* `rofi-firefox-profile`

These will open a profile selector and start firefox with `firefox -P ${PROFILENAME}`.

## Details

Here is everything that's included.

* Firefox launcher bins to start firefox with `firefox -P ${PROFILE}`
* User systemd unit to spy on X11 window changes and find the firefox profile used in that window
    * Writes a state file to `$HOME/.local/var/last-firefox-profile/profile`
* Exe to start firefox with the profile found in that file
    * A companion `firefox-last-profile.desktop` entry so it can be used with xdg

```
❯ make clean && BIN_PREFIX=.local PREFIX=.local make install
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

* **Relies on Firefox launching with the `firefox -P ${PROFILE}`**. Firefox does not do this
by default via `about:profiles` or the `firefox --ProfileManager` manager window.
* Chooses the profile named `default` by default
* `X11` and `systemd` only
* Does not handle "last-window-focused" behavior if you have multiple FF windows with the same profile.
* Janky python3

## Links

* [Mozilla support thread from 2014 describing this desired behavior](https://support.mozilla.org/en-US/questions/999493)
* [A bugzilla request for better multi profile support from 2015](https://bugzilla.mozilla.org/show_bug.cgi?id=1153655)
* [A reddit thread asking how to control which profile external links should open in](https://www.reddit.com/r/firefox/comments/hzjgi3/multiple_open_firefox_profiles_controlling_which/)
    * `--no-remote` has very little documentation and at best can only disqualify a sesssion from opening links.
