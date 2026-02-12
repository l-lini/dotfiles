arr=()
for i in $2; do
    arr+=("$i")
done
l=${#arr[@]};
for ((i=0; i<l; i++)); do
    if [[ ${arr[i]} == "$1" ]]; then
        i=$(((i + $3) % l))
        echo "${arr[i]}"
        break;
    fi
done
