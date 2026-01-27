{
	description = "lini's system configuration";

	inputs = {
		# cachix? What da hell is this??? i'm more confused by the second.
		# nixpkgs.url = "github:nixos/nixpkgs/nixos-25.11";
		nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
		# nixpkgs.url = "github:nixos/nixpkgs";
		# nixpkgs.url = "https://github.com/nixos/nixpkgs/archive/refs/heads/master.tar.gz";
                nixos-fonts.url = "github:Takamatsu-Naoki/nixos-fonts";
                swaymonad.url = "github:nicolasavru/swaymonad";
		home-manager.url = "github:nix-community/home-manager/master";
		md307.url = "github:olillin/eda482-md307-flake";
	};

	outputs = inputs @{ nixpkgs, home-manager, md307, ... }: let
                system = "x86_64-linux";
        in {
		nixosConfigurations = {
			lini = nixpkgs.lib.nixosSystem {
				modules = [
					./system
					md307.nixosModules.default
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
