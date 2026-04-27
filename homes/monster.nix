{ ... }:

{
  imports =
    builtins.map (x: ./../home/${x}) [
      /keyd.nix
      /kitty.nix
      /qutebrowser.nix
      /wofi.nix
    ]
    ++ [
      (import ./../home/sway.nix {
        sway-workspaces = {
          "1" = null;
          "2" = null;
          "3" = null;
          "4" = "spotify";
          "5" = "qsynth";
        };
      })
    ];

  home.username = "lini";
  home.homeDirectory = /home/lini;

  home.stateVersion = "25.11";
}
