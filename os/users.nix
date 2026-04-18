{ pkgs, ... }:

{
  users = {
    defaultUserShell = pkgs.zsh;

    users.lini = {
      isNormalUser = true;
      extraGroups = [
        "wheel"
        # "networkmanager" # make declarative instead
        # "video" # is this for brightnessctl??? i forgor :skull:
      ];
      shell = pkgs.zsh; # why both here and above???
      hashedPasswordFile = "/stay/lini";
    };
  };
}
