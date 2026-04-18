{ ... }:

{
  imports = builtins.map (x: ./../home/${x}) [
    /kitty.nix
    /qutebrowser.nix
    /swaylock.nix
    /sway.nix
    /wofi.nix
  ];

  home.username = "lini";
  home.homeDirectory = /home/lini;

  home.stateVersion = "25.11";
}
