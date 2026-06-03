{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    brightnessctl
  ];

  services.logind.settings.Login = {
    HandleLidSwitch = "suspend";
    HandleLidSwitchExternalPower = "suspend";
    HandleLidSwitchDocked = "suspend";
  };
}
