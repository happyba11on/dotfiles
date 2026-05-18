inotifywait -m -e modify ~/.config/waybar |
while read; do
    killall -SIGUSR2 waybar || waybar &  # or restart the app
done
