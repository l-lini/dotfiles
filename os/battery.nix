{ pkgs, scripts, ... }:

{
  environment.systemPackages = [
    scripts.batteri
  ];

  systemd.user = {
    services.low-battery = {
      enable = true;
      partOf = [ "graphical-session.target" ];
      wantedBy = [ "graphical-session.target" ];
      serviceConfig = {
        Type = "simple";
        ExecStart = pkgs.writeShellScript "low-battery" ''
          if (( 10 >= $(batteri %) )) && [[ "Charging" != $(batteri status) ]];
          then ${pkgs.lib.getExe pkgs.pkgs.libnotify} -t 60000 "$(batteri)";
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
