{ pkgs, ... }:

{
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
