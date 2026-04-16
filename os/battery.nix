{ ... }:
# TODO battery notification daemon
{
  environment.shellAliases.batteri = "echo \"$(cat /sys/class/power_supply/BAT0/capacity) $(cat /sys/class/power_supply/BAT0/status)\"";
}
