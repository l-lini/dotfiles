{
# TODO Store network passwords and spotify password and discord pat in secrets
# TODO Modularize config and do the desktop separation stuffies. https://wiki.nixos.org/wiki/NixOS_system_configuration#Modularizing_your_configuration_with_modules
# TODO lookup how to make nixos rebuil faster
# TODO lookup how to make flake.nix shells faster
# TODO lookup how to make home manager builds faster
	description = "lini's system configuration";

	inputs = {
		nixpkgs.url = "github:nixos/nixpkgs/nixos-25.11";
		nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
                nixos-fonts.url = "github:Takamatsu-Naoki/nixos-fonts";
		home-manager.url = "github:nix-community/home-manager/master";
		md307.url = "github:olillin/eda482-md307-flake";
		chalmers-search-exam.url = "github:olillin/chalmers-search-exam";
		disko.url = "github:nix-community/disko/latest";
	};

	outputs = inputs @{ nixpkgs, nixpkgs-unstable, disko, home-manager, md307, nixos-fonts, chalmers-search-exam, ... }: let
		args = rec {
			inherit inputs;
			system = "x86_64-linux";
			pkgs-unstable = import nixpkgs-unstable { inherit system; };
		};
	in {
		nixosConfigurations = {
			power = nixpkgs.lib.nixosSystem {
				specialArgs = args;
				modules = [
					./system
					md307.nixosModules.default
					home-manager.nixosModules.home-manager {
						home-manager = {
							useGlobalPkgs = true;
							useUserPackages = true;
							users = {
								lini = import ./home;
								root = import ./home;
							};
							extraSpecialArgs = args;
						};
					}
				];
			};
		};
	};
}
