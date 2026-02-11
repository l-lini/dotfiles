ss=$(wpctl status |
    sed -n '/Sources:/,/Filters:/ {p; /Filters:/q}' |
    sed -nE 's/^[^0-9]*([0-9]+)\..*/\1/p')
s=$(wpctl status |
    sed -n '/Sources:/,/Filters:/ {p; /Filters:/q}' |
    sed -nE 's/^[^*]*\* *([0-9]+)\..*/\1/p')
arr=()
for i in $ss; do
    arr+=("$i")
done
echo ${arr[@]}
echo $s
l=${#arr[@]};
for ((i=0; i<l; i++)); do
    echo ${arr[i]}
    if [[ ${arr[i]} == $s ]]; then
        break;
    fi
done
echo $i
echo $(((i + 1) % l))
echo $(((i + 1) % l))
wpctl set-default ${arr[(i + 1) % l]}

