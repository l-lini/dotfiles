{
  home-manager,
  ...
}@args:

{
  _module.args = {
    disk-path = /dev/disk/by-id/nvme-SSSTC_CL1-8D256-HP_UKFCN01ZTF95EW;
  };

  imports = [
    home-manager.nixosModules.home-manager
    ./../nixos/alias.nix
    ./../nixos/networking.nix
    ./../nixos/sway.nix
    ./../nixos/fonts.nix
    ./../nixos/network-manager.nix
    ./../nixos/audio.nix
    ./../nixos/git.nix
    ./../nixos/nix.nix
    ./../nixos/users.nix
    ./../nixos/hardware.nix
    ./../nixos/packages.nix
    ./../nixos/zoxide.nix
    ./../nixos/boot.nix
    ./../nixos/printing.nix
    ./../nixos/zsh.nix
    ./../nixos/console.nix
    ./../nixos/autologin.nix
    ./../nixos/ssh-client.nix
    ./../nixos/disko-install.nix
    ./../nixos/neovim
  ];

  time.timeZone = "Europe/Stockholm";

  home-manager = {
    # useGlobalPkgs = true;
    #useUserPackages = true;
    users.lini.imports = [
      ./../home/kitty.nix
      ./../qutebrowser.nix
      ./../swaylock.nix
      ./../sway.nix
      ./../wofi.nix
      (
        { ... }:
        {
          home.stateVersion = "25.11";
        }
      )
    ];
    extraSpecialArgs = args // {
    };
  };

  system.stateVersion = "25.11";
}
