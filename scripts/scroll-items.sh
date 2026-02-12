arr=()
for i in $2; do
    arr+=("$i")
done
l=${#arr[@]};
echo ${arr[@]}
for ((i=0; i<l; i++)); do
    if [[ ${arr[i]} == $1 ]]; then
        echo ${arr[(i + $3) % l]}
        break;
    fi
done
