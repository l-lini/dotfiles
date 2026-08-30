-- keybinds
vim.g.mapleader = " "
vim.diagnostic.config({
	signs = false,
	underline = false,
})
vim.keymap.set("n", "<C-e>", function()
	vim.diagnostic.config({
		underline = not vim.diagnostic.config().underline,
	})
end)
vim.opt.wrap = false
vim.keymap.set("n", "<C-w>", function()
	vim.opt.wrap = not vim.opt.wrap:get()
end)

-- Remove netrw
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

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

-- colors
vim.api.nvim_set_hl(0, "Normal", { fg = "#ffffff", bg = "#000000" })
vim.api.nvim_set_hl(0, "Identifier", { fg = "#ffffff" })
vim.api.nvim_set_hl(0, "Function", { fg = "#ffffff" })
vim.api.nvim_set_hl(0, "Special", { fg = "#ffffff" })
vim.api.nvim_set_hl(0, "String", { fg = "#ffffff" })
vim.api.nvim_set_hl(0, "Macro", { fg = "#ffffff" })
