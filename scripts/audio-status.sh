if [[ $1 == "sources" ]]; then
    x=$(wpctl status |
        sed -n "/Sources:/,/Filters:/ {p; /Filters:/q}" |
        sed -nE "s/^[^0-9]*([0-9]+)\..*/\1/p" |
        tr '\n' ' ')
    echo "$x"
elif [[ $1 == "sinks" ]]; then
    x=$(wpctl status |
        sed -n "/Sinks:/,/Sources:/ {p; /Sources:/q}" |
        sed -nE "s/^[^0-9]*([0-9]+)\..*/\1/p" |
        tr '\n' ' ')
    echo "$x"
elif [[ $1 == "source" ]]; then
    wpctl status |
        sed -n "/Sources:/,/Filters:/ {p; /Filters:/q}" |
        sed -nE "s/^[^*]*\* *([0-9]+)\..*/\1/p"
elif [[ $1 == "sink" ]]; then
    wpctl status |
        sed -n "/Sinks:/,/Sources:/ {p; /Sources:/q}" |
        sed -nE "s/^[^*]*\* *([0-9]+)\..*/\1/p"
elif [[ $1 == "name" ]]; then
    wpctl inspect "$2" |
        sed -nE "s/^[[:space:]]*alsa\.card_name = \"(.*)\"/\1/p" |
        sed "s/^[[:space:]]*//;s/[[:space:]]*$//"
elif [[ $1 == "volume" ]]; then
    wpctl get-volume "$2" | awk '{printf "%d%% %s\n", $2*100, $3}'
else
    echo "bruh, invalid args"
fi
