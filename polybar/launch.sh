# Taken from https://wiki.archlinux.org/index.php/Polybar#i3
killall -q polybar

while pgrep -u $UID -x polybar > /dev/null; do sleep 1; done

polybar main_bar
