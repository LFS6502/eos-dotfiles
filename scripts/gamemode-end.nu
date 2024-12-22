#!/usr/bin/env nu
picom -b
i3-msg "exec --no-startup-id xborders -c ~/.config/xborders/config"
