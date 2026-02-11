ss=$(wpctl status |
    sed -n "/Sources:/,/Filters:/ {p; /Filters:/q}" |
    sed -nE "s/^[^0-9]*([0-9]+)\..*/\1/p")
s=$(wpctl status |
    sed -n "/Sources:/,/Filters:/ {p; /Filters:/q}" |
    sed -nE "s/^[^*]*\* *([0-9]+)\..*/\1/p")
arr=()
for i in $ss; do
    arr+=("$i")
done
l=${#arr[@]};
for ((i=0; i<l; i++)); do
    if [[ ${arr[i]} == $s ]]; then
        break;
    fi
done
wpctl set-default ${arr[(i + l - 1) % l]}

