if [[ "default" = "$1" ]]; then
    wpctl set-default "$2"
elif [[ "volume" = "$1" ]]; then
    wpctl set-volume "$2" "$3" -l 1
elif [[ "mute" = "$1" ]]; then
    wpctl set-mute "$2" "$3"
else
    echo "bruh, invalid args"
fi
