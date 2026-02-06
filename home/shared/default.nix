{ inputs, config, ... }:

{
  imports = [
    ./sway.nix
    inputs.md307.homeModules.default
    # TODO easy clip saving (my mic also included)
    # TODO Firefox, with extensions and stuffies. Ask Cal!
    # TODO bluetooth shortcut
    # TODO Comic sans and Comic mono fonts.
  ];

  # I want the same environment as root and user.
  programs.zsh.initContent = config.programs.zsh.shellInit;

  home.stateVersion = "25.11";
}
