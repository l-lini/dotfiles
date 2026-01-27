{ pkgs, lib, ... }:

{
	programs.neovim = {
		enable = true;
		defaultEditor = true;
		viAlias = true;
		vimAlias = true;
		initLua = let 
			early = lib.mkOrder 5000 ''
				vim.schedule(function()
					vim.o.clipboard = 'unnamedplus'
				end)
				vim.o.undofile = true
				tabstop = 2
				expandtab = true
				vim.keymap.set("n", "<C-e>", vim.diagnostic.open_float, {
					desc = "Show LSP diagnostic under cursor",
				})
				vim.api.nvim_create_autocmd("FileType", {
					callback = function(args)
						vim.treesitter.start(args.buf)
					end,
				})

			'';
			late = lib.mkAfter "";
		in
			lib.mkMerge [ early late ];
		plugins = with pkgs.vimPlugins; [
			guess-indent-nvim # Please work. I'm begging, begging youuuuuu
			{
				plugin = nvim-lspconfig;
				type = "lua";
				config = ''
					vim.lsp.config('*', { root_markers = { '.git' }, })

                                        local configs = {
                                                { 'hls', {} },
                                                { 'lua_ls', {} },
                                                { 'nil', { filetypes = {'nix'} } },
						{ 'asm_lsp', {  } },
                                        }

                                        for _, lsp in pairs(configs) do
                                                local name, config = lsp[1], lsp[2]
                                                vim.lsp.enable(name)
						vim.lsp.config(name, config)
                                        end
				'';
			}
		{
			plugin = nvim-treesitter.withAllGrammars;
			type = "lua";
			config = ''
				require'nvim-treesitter'.setup {
					build = ':TSUpdate',
				      	main = 'nvim-treesitter.configs',
				      	opts = {
					      	ensure_installed = 'all',
					      	auto_install = true,
					      	highlight = { enable = true },
					      	indent = { enable = true },
				      	},
				}
			'';
		}
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
# TODO notes highlighted
# TODO look at kickstart nvim for inspiration
}
