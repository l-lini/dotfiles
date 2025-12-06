{
# Default to tabwidth = 2
# relative line numbers
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
	enable = true;
	colorschemes.catppuccin.enable = true;
	plugins = {
		lualine.enable = true;
		plugins.undotree = {
			enable = true;
			settings = {
				autoOpenDiff = true;
				focusOnToggle = true;
			};
		};
		nix.enable = true;
		treesitter.enable = true;
	};
}
