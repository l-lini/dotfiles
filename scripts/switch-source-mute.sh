id=$(wpctl status |
    sed -n '/Sources:/,/Filters:/ {p; /Filters:/q}' |
    sed -nE 's/^[^*]*\* *([0-9]+)\..*/\1/p')

wpctl set-mute $id toggle

