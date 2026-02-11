id=$(wpctl status |
    sed -n "/Sources:/,/Filters:/ {p; /Filters:/q}" |
    sed -nE "s/^[^*]*\* *([0-9]+)\..*/\1/p")

name=$(wpctl inspect $id | sed -nE "s/^[[:space:]]*alsa\.card_name = \"(.*)\"/\1/p" | sed "s/^[[:space:]]*//;s/[[:space:]]*$//")

volume=$(wpctl get-volume $id | awk '{printf "%d%% %s\n", $2*100, $3}')

echo "$name $volume"

