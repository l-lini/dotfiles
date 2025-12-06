{
	description = "lini's system configuration";

	inputs = {
		# cachix?
		nixpkgs.url = "github:nixos/nixpkgs/nixos-25.11";
		nixpkgs-instable.url = "github:nixos/nixpkgs/nixos-unstable";
		nixvim = {
			url = "github:nix-community/nixvim/nixos-25.11";
			inputs.nixpkgs.follows = "nixpkgs";
		};
		home-manager = {
			url = "github:nix-community/home-manager/release-25.11";
			inputs.nixpkgs.follows = "nixpkgs";
		};
	};

	outputs = inputs @{ nixpkgs, home-manager, nixvim, ... }: {
		nixosConfigurations = {
			lini = nixpkgs.lib.nixosSystem {
				modules = [
					./config/config.nix
					nixvim.homeModules.nixvim
					home-manager.nixosModules.home-manager {
						home-manager.useGlobalPkgs = true;
						home-manager.useUserPackages = true;
						home-manager.users.lini = import ./home/lini;
						home-manager.extraSpecialArgs = {
							nixvim = nixvim;
						};
					}
				];
			};
		};
	};
}
