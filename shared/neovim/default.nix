{ pkgs, ... }:

{
	programs.neovim = {
		enable = true;
		defaultEditor = true;
		viAlias = true;
		vimAlias = true;
		configure = {
			customLuaRC = builtins.readFile ./init.lua; 
			# packages.myVimPackage = with pkgs.vimPlugins; [ ];
		};
	};
}
# stop autocomplete in comments. fuck you bitch. that's fucking dumb as hell. 
# Default to tabwidth = 2
# relative line numbers
# relative line numbers in explorer
# grep thingie in folder
# disable arrow keys
# disable mouse (in all terminal instances and neovim etc...) ()
# lsp easy
# tree-sitter easy
# auto indent detection
# harpoon or fuzzy finder or file explorer or similar (pick one)
# undo-tree
# system clipboard
# Auto format
# Autosave on close
# Auto sudo on write protected
# haskell with good lsp. hlint builtin.
# Se lsp and tree-sitter errors
# Autocomplete
# TODO notes highlighted
# TODO look at kickstart nvim for inspiration
