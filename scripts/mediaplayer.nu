#!/usr/bin/env nu
let icon = match (playerctl status e> ignore | echo $in) {
    Playing => "⏵",
    Paused => "⏸",
    _ => (print ""; exit 0)
}

let data = [
    (playerctl metadata album e> ignore),
    (playerctl metadata title e> ignore)
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
