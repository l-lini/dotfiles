{ pkgs, ... }:

{
	programs.neovim = {
		enable = true;
		defaultEditor = true;
		viAlias = true;
		vimAlias = true;
		plugins = with pkgs.vimPlugins; [
			{
				plugin = nvim-lspconfig;
				type = "lua";
				config = ''
					vim.lsp.config('*', {
						capabilities = {
							textDocument = {
								semanticTokens = {
									multilineTokenSupport = true,
								}
							}
						},
						root_markers = { '.git' },
					})

					vim.lsp.config('hls', {})
					vim.lsp.config('lua_ls', {})
					vim.lsp.config('rnix-lsp', {})'';
			}
			nvim-treesitter.withAllGrammars
			# telescope-nvim
			# telescope-fzf-native-nvim
			# harpoon
			# vim-fugitive
			# {
			# 	plugin = nvim-lspconfig;
			# 	type = "lua";
			# 	config = "require('lspconfig').hls.setup {};";
			# }
			# use coc-nvim to have LSP
		];
		extraPackages = [];
	};
        # All these neovim distros for nix suck as. Just do it the way it's intended.
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
}
