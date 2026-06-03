if [[ $# -eq 0 ]]; then
  echo "$(cat /sys/class/power_supply/BAT0/capacity) $(cat /sys/class/power_supply/BAT0/status)";
elif [[ $1 == "%" ]]; then
  cat /sys/class/power_supply/BAT0/capacity;
elif [[ $1 == "status" ]]; then
    cat /sys/class/power_supply/BAT0/status;
fi
