# TODO! Ephemeral Root
{
  inputs,
  pkgs,
  pkgs-unstable,
  system,
  scripts,
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
    steam.enable = true; # gaming # TODO! Fix random persistant lag
    sway.enable = true; # sway lol
    direnv.enable = true;
  };

  # You can use https://search.nixos.org/ to find more packages (and options).
  environment.systemPackages =
    with pkgs;
    builtins.attrValues scripts
    ++ [
      inputs.chalmers-search-exam.packages.${system}.default # clients
      minitube # clients
      qsynth # clients
      gcc
      spotify # clients
      glow
      git-crypt
      dust
      tigervnc # clients
      stunnel # clients
      unzip
      ffmpeg # clients
      erlang # clients
      prusa-slicer # clients
      tree-sitter # clients
      prismlauncher # gaming
      heroic # gaming
      pavucontrol # audio
      pamixer # audio
      r2modman # gaming
      inkscape # sway
      git
      mpv
      mupdf # sway
      tree
      screen # clients
      grim # sway
      slurp # sway
      wl-clipboard # sway
      discord # sway
      slack # sway
      libnotify # sway
      firefox # sway
      qutebrowser # sway
      autotiling # sway
    ]
    ++ (with pkgs-unstable; [
      nvcat
    ]);

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
  };

}
