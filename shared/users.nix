{ pkgs, ... }:

{
  users = {
    defaultUserShell = pkgs.zsh;

    users.lini = {
      isNormalUser = true;
      extraGroups = [
        "wheel"
        "networkmanager"
        "video"
      ];
      shell = pkgs.zsh;
    };
  };
}
