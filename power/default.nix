{ ... }:

{
  imports = [
    ../shared
    ./hardware.nix
    ./disko.nix
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
