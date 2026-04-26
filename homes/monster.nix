{ ... }:

{
  imports = builtins.map (x: ./../home/${x}) [
    /keyd.nix
    /kitty.nix
    /qutebrowser.nix
    /sway.nix
    /wofi.nix
  ];

  home.username = "lini";
  home.homeDirectory = /home/lini;

  home.stateVersion = "25.11";
}
