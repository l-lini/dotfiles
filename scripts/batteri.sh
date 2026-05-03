if [[ $1 == "%" ]]; then
  echo "$(cat /sys/class/power_supply/BAT0/capacity)";
elif [[ $1 == "status" ]]; then
    echo "$(cat /sys/class/power_supply/BAT0/status)";
else
  echo "$(cat /sys/class/power_supply/BAT0/capacity) $(cat /sys/class/power_supply/BAT0/status)";
fi
