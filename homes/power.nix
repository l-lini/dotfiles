{ ... }:

{
  imports = [
    ./../home/kitty.nix
    ./../qutebrowser.nix
    ./../swaylock.nix
    ./../sway.nix
    ./../wofi.nix
  ];

  home.stateVersion = "25.11";
}
