{ inputs, ... }:

{
        imports = [
                ./sway.nix
		# TODO Firefox, with extensions and stuffies. Ask Cal!
		# TODO bluetooth shortcut
		# TODO Comic sans and Comic mono fonts.
		inputs.md307.homeModules.default
        ];

        home.stateVersion = "25.11";
}
