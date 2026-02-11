id=$(wpctl status |
    sed -n "/Sinks:/,/Sources:/ {p; /Sources:/q}" |
    sed -nE "s/^[^*]*\* *([0-9]+)\..*/\1/p")

wpctl set-volume $id 0.05+ -l 1

