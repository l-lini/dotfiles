{
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
      args = rec {
        inherit inputs util;
        pkgs-unstable = import nixpkgs-unstable {
          inherit system;
          nixpkgs.allowUnfree = true;
        };
        system = "x86_64-linux";
        os = util.dirToAttr ./os util.pathToName (path: _: import path);
        home = util.dirToAttr ./home util.pathToName (path: _: import path);
        username = "lini";
        homeDirectory = /home/lini;
        secrets =
          if !builtins.pathExists /stay then
            builtins.trace "\nWARNING!!!: /stay doesn't exist, enable --impure please\n" { }
          else
            util.dirToAttr /stay builtins.baseNameOf (path: _: builtins.readFile path);
        scripts = util.dirToAttr ./scripts util.pathToName (
          path: name:
          (import nixpkgs {
            inherit system;
            nixpkgs.allowUnfree = true;
          }).writeShellApplication
            {
              inherit name;
              text = builtins.readFile path;
            }
        );
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
      homeConfigurations = util.dirToAttr ./homes (path: "${args.username}@${util.pathToName path}") (
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
