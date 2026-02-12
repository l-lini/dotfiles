if [[ "$1" == "sink" ]]; then
    x="$(audio-status sink)"
    xs="$(audio-status sinks)"
    nx=$(scroll-items "$x" "$xs" "$2")
    audio-changer default "$nx"
elif [[ "$1" == "source" ]]; then
    x="$(audio-status source)"
    xs="$(audio-status sources)"
    nx=$(scroll-items "$x" "$xs" "$2")
    audio-changer default "$nx"
else
    echo "nah fam you cooked. :skull:"
fi
