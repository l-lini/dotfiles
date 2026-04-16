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
    { nixpkgs, home-manager, ... }@inputs:
    let
      util = import ./util.nix;
    in
    {
      nixosConfigurations = util.dirToAttr ./oss util.pathToName (
        path: hostName:
        nixpkgs.lib.nixosSystem {
          specialArgs = {
            inherit inputs util;
            system = "x86_64-linux";
            pencils = import ./pencils.nix;
            secrets = util.readDirFiles /stay;
            scripts = { };
            inherit hostName;
          };
          modules = [
            path
          ];
        }
      );
      homeConfigurations = util.dirToAttr ./homes (path: "lini@${util.pathToName path}") (
        path: hostName:
        home-manager.lib.homeManagerConfiguration {
          modules = [ path ];
        }
      );
    };
}
