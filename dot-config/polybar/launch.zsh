#!/usr/bin/env zsh

polybar-msg cmd quit

#polybar -c ~/.config/polybar/bar1.ini bar1 2>&1 | tee -a /tmp/polybar1.log & disown


echo "---" | tee -a /tmp/polybar1.log /tmp/polybar2.log

if type "xrandr"; then
  for m in $(xrandr --query | grep " connected" | cut -d" " -f1 | tac); do 
    MONITOR=$m polybar -c ~/.config/polybar/bar1.ini bar1 --reload &
    sleep 0.1s
  done
else
  polybar --reload example &
fi

echo "Bars launched..."
