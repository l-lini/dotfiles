-- keybinds
vim.g.mapleader = " "
vim.keymap.set("n", "<leader>e", vim.cmd.Ex)

-- lsp
vim.lsp.enable({ 'nil', 'lua_ls', 'rust_analyzer' })
vim.lsp.config('nil', {
	cmd = { "nil" },
	filetypes = { "nix" },
})
vim.lsp.config('lua_ls', {})
vim.lsp.config('*', {
	root_markers = { '.git' },
})

-- auto format on write
vim.api.nvim_create_autocmd("BufWritePre", {
	callback = function(args)
		vim.lsp.buf.format()
	end
})

-- treesitter callback
vim.api.nvim_create_autocmd("Filetype", {
	callback = function(args)
		local ok = pcall(vim.treesitter.start, args.buf)
	end,
})
