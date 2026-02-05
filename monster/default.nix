{ secrets, ... }:

{
  imports = [
    ../shared
    ./hardware.nix # TODO
    ./disko.nix # TODO
  ];

  services.spotifyd = {
    enable = true;
    settings.global = {
      username = "linus_lego";
      password = secrets.spotify;
      device_name = "monster";
    };
  };
}
