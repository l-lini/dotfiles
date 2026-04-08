{
  # TODO switch to sops-nix
  description = "lini's system configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.11";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager/release-25.11";
    disko.url = "github:nix-community/disko/latest";

    md307.url = "github:olillin/eda482-md307-flake";
    chalmers-search-exam.url = "github:olillin/chalmers-search-exam";
  };

  outputs =
    inputs@{
      nixpkgs,
      nixpkgs-unstable,
      disko,
      home-manager,
      md307,
      chalmers-search-exam,
      ...
    }:
    let
      argsWith = f: rec {
        inherit inputs;
        system = "x86_64-linux";
        pencils = import ./pencils.nix;
        pkgs-unstable = import nixpkgs-unstable {
          inherit system;
          config.allowUnfree = true;
        };
        pkgs = import nixpkgs {
          inherit system;
          config.allowUnfree = true;
        };
        secrets =
          with builtins;
          let
            secretPaths = nixpkgs.lib.filesystem.listFilesRecursive ./secrets;
            pathToPair = path: {
              name = baseNameOf path;
              value = f path;
            };
          in
          listToAttrs (map pathToPair secretPaths);
        scripts = import ./scripts/scripts.nix {
          inherit pkgs;
          lib = pkgs.lib;
        };
      };
      generateSystem =
        hostName: args:
        nixpkgs.lib.nixosSystem {
          specialArgs = args // {
            inherit hostName;
          };
          modules = [
            ./hosts/${hostName}
          ];
        };
    in
    {
      nixosConfigurations = {
        monster = generateSystem "monster" (argsWith builtins.readFile);
      };
    };
}
