{ pkgs, ... }:

let
  batteri = ''echo "$(cat /sys/class/power_supply/BAT0/capacity) $(cat /sys/class/power_supply/BAT0/status)"'';
in
{
  environment.shellAliases = {
    inherit batteri;
  };

  systemd.user = {
    services.low-battery = {
      enable = true;
      partOf = [ "graphical-session.target" ];
      wantedBy = [ "graphical-session.target" ];
      serviceConfig = {
        Type = "simple";
        ExecStart = pkgs.writeShellScript "low-battery" ''
          level=$(cat /sys/class/power_supply/BAT0/capacity);
          status=$(cat /sys/class/power_supply/BAT0/status);
          if (( 10 >= $level )) && [[ "Charging" != $status ]];
          then ${pkgs.lib.getExe pkgs.pkgs.libnotify} -t 60000 "$level $status";
          fi;
        '';
      };
    };
    timers.low-battery = {
      wantedBy = [ "timers.target" ];
      timerConfig = {
        OnCalendar = "*-*-* *:*:00";
        Unit = "low-battery.service";
      };
    };
  };
}
