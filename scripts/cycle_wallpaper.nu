#!/bin/env nu
def main [direction: string] {
  cd ~/Backgrounds
  let total = ls | length | into int
  let current = open .index | into int

  let new = if $direction == "next" {
    ($current + 1) mod $total
  } else if $direction == "previous" {
    ($current - 1) mod $total
  } else {
    error make {msg: "Invalid argument: [ next | previous ]"}
  }

  $new | save .index -f
  let file = ls | get $new | get name
  feh --bg-fill $file
  let notif_body = $"<b>($new)</b> - ($file)" 
  notify-send -t 2000 "Wallpaper" $notif_body
}
