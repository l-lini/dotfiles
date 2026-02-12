# TODO! Ephemeral Root
{
  inputs,
  pkgs,
  pkgs-unstable,
  system,
  ...
}:

{
  imports = [
    ./networking.nix
    ./neovim
    ./zoxide.nix
    ./zsh.nix
    ./git.nix
    ./bluetooth.nix
    ./users.nix
    ./fcitx5.nix
    ./fonts.nix
    ./login.nix
    ./nix.nix
    ./console.nix
    ./boot.nix
    inputs.md307.nixosModules.default
  ];

  nixpkgs.config.allowUnfree = true;

  programs = {
    steam.enable = true; # TODO! Fix random persistant lag
    sway.enable = true;
    direnv.enable = true;
  };

  # You can use https://search.nixos.org/ to find more packages (and options).
  environment.systemPackages =
    with pkgs;
    [
      inputs.chalmers-search-exam.packages.${system}.default
      minitube # Super basic youtube app
      qsynth
      gcc
      spotify
      glow
      playerctl
      git-crypt
      dust
      tigervnc
      stunnel
      unzip
      ffmpeg
      erlang
      prusa-slicer
      tree-sitter
      prismlauncher
      heroic
      pavucontrol
      pamixer
      r2modman
      anki
      inkscape
      git
      mpv
      mupdf
      tree
      screen
      grim
      slurp
      wl-clipboard
      discord
      slack
      libnotify
      firefox
      qutebrowser # Imagine if it actually worked ):
      autotiling
    ]
    ++ (with pkgs-unstable; [
      nvcat
    ]);

  # Set the default editor to neovim
  environment.variables.EDITOR = "nvim";

  # Set your time zone.
  time.timeZone = "Europe/Stockholm";

  services = {
    # CUPS
    printing.enable = true;
    # Sound
    pipewire = {
      enable = true;
      pulse.enable = true;
    };

    openssh.enable = true;

    # TODO add this to specifically the project in question
    # mariadb-connector-java
    # jdk25_headless
    # maven
    # android-studio
    # mysql = {
    #   enable = true;
    #   package = pkgs.mariadb;
    # };
  };

  system.stateVersion = "25.11";
}
