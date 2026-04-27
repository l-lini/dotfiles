{ inputs, ... }:

{
  imports =
    builtins.map (x: ./../home/${x}) [
      /kitty.nix
      /keyd.nix
      /qutebrowser.nix
      /swaylock.nix
      /wofi.nix
    ]
    ++ [
      (import ./../home/sway.nix {
        sway-workspaces = {
          "1" = null;
          "2" = null;
          "3" = null;
        };
      })
    ]
    ++ [
      inputs.dat566.homeModules.vscode
    ];

  home.username = "lini";
  home.homeDirectory = /home/lini;

  home.stateVersion = "25.11";
}
