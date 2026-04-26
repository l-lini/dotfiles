{ pkgs, ... }:

{
  environment.shellAliases.batteri = "echo \"$(cat /sys/class/power_supply/BAT0/capacity) $(cat /sys/class/power_supply/BAT0/status)\"";

  systemd.user = {
    services.low-battery = {
      enable = true;
      partOf = [ "graphical-session.target" ];
      wantedBy = [ "graphical-session.target" ];
      serviceConfig = {
        Type = "simple";
        ExecStart = pkgs.writeShellScript "low-battery" ''
          if (( 27 >= $(cat /sys/class/power_supply/BAT0/capacity)));
          then ${pkgs.lib.getExe pkgs.pkgs.libnotify} --urgency=critical "$(batteri)";
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
