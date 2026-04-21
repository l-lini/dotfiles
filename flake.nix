{
  # TODO switch to sops-nix
  description = "lini's system configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.11";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager/release-25.11";
    disko.url = "github:nix-community/disko/latest";
    md307.url = "github:olillin/eda482-md307-flake";
    dat566.url = "github:LinuxAtChalmers/dat566-flake";
    chalmers-search-exam.url = "github:olillin/chalmers-search-exam";
  };

  outputs =
    {
      nixpkgs,
      nixpkgs-unstable,
      home-manager,
      ...
    }@inputs:
    let
      util = import ./util.nix;
      args = {
        inherit inputs util;
        system = "x86_64-linux";
        os = util.dirToAttr ./os util.pathToName (path: _: import path);
        home = util.dirToAttr ./home util.pathToName (path: _: import path);
        pencils = import ./pencils.nix;
        secrets =
          if !builtins.pathExists /stay then
            builtins.trace "\nWARNING!!!: /stay doesn't exist, enable --impure please\n" { }
          else
            util.dirToAttr /stay builtins.baseNameOf (path: _: builtins.readFile path);
        scripts = { };
      };
    in
    {
      nixosConfigurations = util.dirToAttr ./oss util.pathToName (
        path: hostName:
        nixpkgs.lib.nixosSystem {
          specialArgs = {
            inherit hostName;
          }
          // args;
          modules = [
            path
          ];
        }
      );
      homeConfigurations = util.dirToAttr ./homes (path: "lini@${util.pathToName path}") (
        path: hostName:
        home-manager.lib.homeManagerConfiguration {
          pkgs = import nixpkgs {
            inherit (args) system;
            config.allowUnfree = true;
          };
          extraSpecialArgs = {
            inherit hostName;
          }
          // args;
          modules = [ path ];
        }
      );
    };
}
