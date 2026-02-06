{
  pencils,
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
    colors = [
      pencils.black
      pencils.red
      pencils.green
      pencils.yellow
      pencils.blue
      pencils.magenta
      pencils.cyan
      pencils.white
      pencils.bright.black
      pencils.bright.red
      pencils.bright.green
      pencils.bright.yellow
      pencils.bright.blue
      pencils.bright.magenta
      pencils.bright.cyan
      pencils.bright.white
    ];
  };
}
