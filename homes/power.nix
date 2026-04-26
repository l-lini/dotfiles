{ inputs, ... }:

{
  imports =
    builtins.map (x: ./../home/${x}) [
      /kitty.nix
      /keyd.nix
      /qutebrowser.nix
      /swaylock.nix
      /sway.nix
      /wofi.nix
    ]
    ++ [
      inputs.dat566.homeModules.vscode
    ];

  home.username = "lini";
  home.homeDirectory = /home/lini;

  home.stateVersion = "25.11";
}
