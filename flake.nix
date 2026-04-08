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
    { nixpkgs, ... }@inputs:
    let
      lib = import ./lib.nix;
    in
    {
      nixosConfigurations = lib.dirToAttr ./hosts (path: lib.removeEnd ".nix" (baseNameOf path)) (
        path:
        nixpkgs.lib.nixosSystem {
          specialArgs = {
            inherit inputs lib;
            system = "x86_64-linux";
            pencils = import ./pencils.nix;
            secrets = lib.readDirFiles ./stay;
            scripts = { };
            hostName = baseNameOf path;
          };
          modules = [
            path
          ];
        }
      );
    };
}
