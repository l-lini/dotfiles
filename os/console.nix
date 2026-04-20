{
  util,
  pkgs,
  lib,
  ...
}:

{
  systemd.services.reload-systemd-vconsole-setup.serviceConfig.ExecStart = lib.mkForce (
    pkgs.writeShellScript "reset-console" ''
      until test -c /dev/dri/card1; do sleep 1; done
      ${pkgs.systemd}/lib/systemd/systemd-vconsole-setup
    ''
  );

  console = {
    earlySetup = true;
    font = "latarcyrheb-sun32"; # Enums, why are they not enums );
    colors = util.pencil.console_colors;
  };
}
