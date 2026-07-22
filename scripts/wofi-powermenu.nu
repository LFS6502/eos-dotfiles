#!/usr/bin/env nu

let entries = [
    "Shutdown"
    "Reboot"
    "Logout"
    "Lock"
    "Cancel"
] | str join "\n"

let selected = ($entries | wofi --dmenu --prompt "Power Menu" --cache-file /dev/null | str trim)

match $selected {
    "Shutdown" => { hyprshutdown -t "Shutting down..." --post-cmd "systemctl poweroff" }
    "Reboot"   => { hyprshutdown -t "Restarting..." --post-cmd "systemctl reboot" }
    "Logout"   => { hyprshutdown -t "Logging out..." }
    "Lock"     => { hyprlock }
    _          => {}
}
