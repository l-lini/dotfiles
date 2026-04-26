{
  inputs,
  pkgs,
  # pkgs-unstable,
  system,
  ...
}:

{
  programs.direnv.enable = true;

  environment.systemPackages = with pkgs; [
    inputs.chalmers-search-exam.packages.${system}.default
    gcc
    glow
    dust
    unzip
    mpv
    tree
    screen
    ffmpeg
    erlang
    tree-sitter
    tigervnc
    stunnel
    efibootmgr
    disko
  ];
  # ++ (with pkgs-unstable; [
  #   nvcat
  # ]);
}
