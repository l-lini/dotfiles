{
# TODO switch to sops-nix
# TODO Store network passwords and spotify password and discord pat in secrets
# TODO Ephemeral root your Downloads folder. Nothing of value should be there. Teach yourself this through this measure.
# TODO Modularize config and do the desktop separation stuffies. https://wiki.nixos.org/wiki/NixOS_system_configuration#Modularizing_your_configuration_with_modules
# TODO lookup how to make nixos rebuil faster
# TODO lookup how to make flake.nix shells faster
# TODO lookup how to make home manager builds faster
	description = "lini's system configuration";

	inputs = {
		nixpkgs.url = "github:nixos/nixpkgs/nixos-25.11";
		nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
		home-manager.url = "github:nix-community/home-manager/release-25.11";
                nixos-fonts.url = "github:Takamatsu-Naoki/nixos-fonts";
		disko.url = "github:nix-community/disko/latest";

		md307.url = "github:olillin/eda482-md307-flake";
		chalmers-search-exam.url = "github:olillin/chalmers-search-exam";
	};

	outputs = inputs @{ nixpkgs, nixpkgs-unstable, disko, home-manager, md307, nixos-fonts, chalmers-search-exam, ... }: let
		args = rec {
			inherit inputs;
			system = "x86_64-linux";
			pkgs-unstable = import nixpkgs-unstable {
				inherit system;
				config.allowUnfree = true;
			};
			secrets = with builtins; let
				secretPaths = nixpkgs.lib.filesystem.listFilesRecursive ./secrets;
				pathToPair = path: {
					name = baseNameOf path;
					value = readFile path;
				};
			in listToAttrs (map pathToPair secretPaths);
		};
		generateSystem = hostname: nixpkgs.lib.nixosSystem {
			specialArgs = args // { inherit hostname; };
			modules = [
				./${hostname}
				(generateHomeManagerModule hostname)
			];
		};
		generateHomeManagerModule = hostname: {
			imports = [ home-manager.nixosModules.home-manager ];
			home-manager = {
				useGlobalPkgs = true;
				#useUserPackages = true;
				users.lini = import ./home/${hostname};
				extraSpecialArgs = args // { inherit hostname; };
			};
		};
	in {
		nixosConfigurations = {
			power = generateSystem "power";
			monster = generateSystem "monster";
		};
	};
}
