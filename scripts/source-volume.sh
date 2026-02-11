s=$(wpctl status |
    sed -n '/Sources:/,/Filters:/ {p; /Filters:/q}' |
    sed -nE 's/^[^*]*\* *([0-9]+)\..*/\1/p')
wpctl get-volume $s | awk '{printf "%d%% %s\n", $2*100, $3}'
