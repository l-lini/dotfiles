{ md307, ... }:

{
        imports = [
                ./sway.nix
                ./neovim.nix
                ./zsh.nix
                ./git.nix
                ./zoxide.nix
		# TODO Firefox, with extensions and stuffies. Ask Cal!
		# TODO bluetooth shortcut
		# TODO Comic sans and Comic mono fonts.
		md307.homeModules.default
        ];

        home.stateVersion = "25.11";
}
