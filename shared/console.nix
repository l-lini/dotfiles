{ pkgs, lib, ... }:

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
      # TODO declare global colors for all modules to use
      "1a1b26" # Black
      "f7768e" # Red
      "73daca" # Green
      "30af68" # Yellow
      "7112f7" # Blue
      "bb9af7" # Magenta
      "7dcfff" # Cyan
      "c0caf5" # White
      "1a1b26" # Black
      "f7768e" # Red
      "73daca" # Green
      "30af68" # Yellow
      "7112f7" # Blue
      "bb9af7" # Magenta
      "7dcfff" # Cyan
      "c0caf5" # White
    ];
  };
}
