{ inputs, ... }:

{
  imports = [
    ./sway.nix
    inputs.md307.homeModules.default
    # TODO easy clip saving (my mic also included)
    # TODO Firefox, with extensions and stuffies. Ask Cal!
    # TODO bluetooth shortcut
    # TODO Comic sans and Comic mono fonts.
  ];

  programs.zsh.initContent = "# Shutup bitch - John Cena";
  home.stateVersion = "25.11";
}
