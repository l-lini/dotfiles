{ username, hostName, ... }:

{
  environment.shellAliases = {
    test-nixos = "sudo nixos-rebuild test --impure --flake .#${hostName}";
    switch-nixos = "sudo nixos-rebuild switch --impure --flake .#${hostName}";
    switch-home = "home-manager switch --flake .#${username}@${hostName}";
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
