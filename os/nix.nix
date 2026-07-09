{ username, hostName, ... }:

{
  environment.shellAliases = {
    test-nixos = "sudo nixos-rebuild test --impure --flake .#${hostName}";
    switch-nixos = "sudo nixos-rebuild switch --impure --flake .#${hostName}";
    test-home = "home-manager test --impure --flake .#${username}@${hostName}";
    switch-home = "home-manager switch --impure --flake .#${username}@${hostName}";
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
