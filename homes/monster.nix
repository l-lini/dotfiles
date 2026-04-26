{ inputs, ... }:

{
  imports = builtins.map (x: ./../home/${x}) [
    /home-manager.nix
    /kitty.nix
    /qutebrowser.nix
    /sway.nix
    /wofi.nix
  ];

  home.username = "lini";
  home.homeDirectory = /home/lini;

  home.stateVersion = "25.11";
}
