{
	description = "lini's system configuration";

	inputs = {
		# cachix?
		nixpkgs.url = "github:nixos/nixpkgs/nixos-25.11";
		# nixpkgs-instable.url = "github:nixos/nixpkgs/nixos-unstable";
                nixos-fonts.url = "github:Takamatsu-Naoki/nixos-fonts";
		nvf.url = "github:notashelf/nvf";
                swaymonad.url = "github:nicolasavru/swaymonad";
		home-manager.url = "github:nix-community/home-manager/release-25.11";
	};

	outputs = inputs @{ nixpkgs, home-manager, nvf, ... }: let
                system = "x86_64-linux";
        in {
		nixosConfigurations = {
			lini = nixpkgs.lib.nixosSystem {
				modules = [
					./system
					nvf.nixosModules.default
					home-manager.nixosModules.home-manager {
						home-manager.useGlobalPkgs = true;
						home-manager.useUserPackages = true;
						home-manager.users = {
                                                        lini = import ./home;
                                                        root = import ./home;
                                                };
					}
                                        {
                                                _module.args = { inherit inputs; };
                                        }
				];
			};
		};
	};
}
