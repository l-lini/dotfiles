{
	description = "lini's system configuration";

	inputs = {
		# cachix?
		nixpkgs.url = "github:nixos/nixpkgs/nixos-25.11";
		# nixpkgs-instable.url = "github:nixos/nixpkgs/nixos-unstable";
		nvf.url = "github:notashelf/nvf";
		home-manager.url = "github:nix-community/home-manager/release-25.11";
	};

	outputs = inputs @{ nixpkgs, home-manager, nvf, ... }: {
		nixosConfigurations = {
			lini = nixpkgs.lib.nixosSystem {
				modules = [
					nvf.nixosModules.default
					home-manager.nixosModules.home-manager {
						home-manager.useGlobalPkgs = true;
						home-manager.useUserPackages = true;
						home-manager.users.lini = import ./home/lini;
					}
					./config/config.nix
				];
			};
		};
	};
}
