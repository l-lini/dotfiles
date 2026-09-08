{ username, hostName, ... }:

{
  environment.shellAliases =
    let
      config_path = "/home/lini/nixos";
    in
    {
      test-nixos = "sudo nixos-rebuild test --impure --flake ${config_path}#${hostName}";
      switch-nixos = "sudo nixos-rebuild switch --impure --flake ${config_path}#${hostName}";
      switch-home = "home-manager switch --flake ${config_path}#${username}@${hostName}";
    };
  nix = {
    settings.experimental-features = [
      "nix-command"
      "flakes"
    ];
    gc = {
      automatic = true;
      dates = "daily";
      options = "--delete-older-than 7d";
    };
  };
}
