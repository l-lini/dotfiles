{ pkgs, ... }:

{
  imports = [
    ../shared
    ./hardware.nix
    ./disko-install.nix
    ./tlp.nix
  ];

  environment.systemPackages = with pkgs; [
    brightnessctl
    acpid
  ];

  services.logind.settings.Login = {
    HandleLidSwitch = "lock";
    HandleLidSwitchExternalPower = "lock";
    HandleLidSwitchDocked = "lock";
  };

  services.acpid = {
    enable = true;
    lidEventCommands = "swaylock";
  };
}
