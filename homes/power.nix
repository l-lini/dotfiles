{ inputs, ... }:

{
  imports =
    builtins.map (x: ./../home/${x}) [
      /kitty.nix
      /swayidle.nix
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
        sway-startup = [
          {
            command = "swayidle -w before-sleep 'swaylock' timeout 0 'swaylock'";
            always = true;
          }
        ];
      })
    ]
    ++ [
      inputs.dat566.homeModules.vscode
    ];

  home.username = "lini";
  home.homeDirectory = /home/lini;

  home.stateVersion = "25.11";
}
