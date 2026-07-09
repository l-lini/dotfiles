{ pkgs, username, ... }:

{
  users = {
    defaultUserShell = pkgs.zsh;

    users.${username} = {
      isNormalUser = true;
      extraGroups = [
        "wheel"
        # "video" # is this for brightnessctl??? i forgor :skull:
      ];
      shell = pkgs.zsh; # why both here and above???
      hashedPasswordFile = "/stay/${username}";
    };
  };
}
