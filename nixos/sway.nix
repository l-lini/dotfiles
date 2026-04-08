{ pkgs, ... }:

{
  program = {
    steam.enable = true; # TODO! Fix random persistant lag
    sway.enable = true;
  };

  # I hope it merges correctly by default
  environment.shellAliases = {
    arbetsplats = "swaymsg -t get_workspaces -r | jq \".[] | select(.focused) | .num\"";
    placera = "autotiler -l 2"; # TODO different depending on system
    "skärmdump" = "slurp | grim -g - - | wl-copy";
  };

  # Autostart sway
  environment.loginShellInit = "[[ \"$(tty)\" == /dev/tty1 ]] && sway";

  environment.systemPackages = with pkgs; [
    jq
    minitube
    spotify
    prismlauncher
    heroic
    r2modman
    prusa-slicer
    qsynth
    pavucontrol
    inkscape
    mupdf
    grim
    slurp
    wl-clipboard
    discord
    slack
    libnotify
    firefox
    qutebrowser
    autotiling
  ];
}
