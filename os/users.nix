{ pkgs, ... }:

{
  users = {
    defaultUserShell = pkgs.zsh;

    users.lini = {
      isNormalUser = true;
      extraGroups = [
        "wheel"
        # "video" # is this for brightnessctl??? i forgor :skull:
      ];
      shell = pkgs.zsh; # why both here and above???
      hashedPasswordFile = "/stay/lini";
    };
  };
}
