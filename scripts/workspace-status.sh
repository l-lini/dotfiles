swaymsg -t get_workspaces -r | jq ".[] | select(.focused) | .num"

