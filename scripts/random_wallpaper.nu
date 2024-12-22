#!/usr/bin/env nu
cd ~/Backgrounds
let total = ls | length
let rand = random int ..($total - 1)
let file = ls | get $rand | get name
$rand | save .index -f
feh --bg-fill $file
let notif_body = $"<b>($rand)</b> - ($file)" 
notify-send -t 2000 "Wallpaper" $notif_body
