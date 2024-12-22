#!/usr/bin/env nu
use std
let icon = match (playerctl status e> (std null-device) | echo $in) {
    Playing => "⏵",
    Paused => "⏸",
    _ => (print ""; exit 0)
}

let data = [
    (playerctl metadata album e> (std null-device)),
    (playerctl metadata title e> (std null-device))
]

match $data {
    ["", $title] => {
        playerctl metadata --format ($icon + " {{trunc(title, 40)}} - {{trunc(artist,25)}}")
    },
    [$album, $title] if $album == $title => {
        playerctl metadata --format ($icon +  " {{trunc(title, 40)}} - {{trunc(artist, 25)}}")
    },
    [$album, $title] => {
        playerctl metadata --format ($icon + " {{trunc(title, 40)}} - {{trunc(artist, 25)}} - {{trunc(album, 25)}}")
    }
    _ => "No players"
} 
