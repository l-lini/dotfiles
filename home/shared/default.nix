{ config, pkgs, ... } :

{
	programs.nixvim = import ./nixvim.nix;

	home.stateVersion = "25.11";
}
