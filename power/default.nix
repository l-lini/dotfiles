{ pkgs, ... }:

{
  imports = [
    ../shared
    ./hardware.nix
    ./disko-install.nix
    ./tlp.nix
  ];

  users.users.lini = {
    initialPassword = "$y$j9T$BawzOnCgU6zGTOayD5Z29/$ERhA6KSj78VvC4qOozPuUXSaKfDWhfQjXAe98jIsQYA";
    hashedPasswordFile = /persist/password;
  };

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
