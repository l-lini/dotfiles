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
vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float)
vim.opt.wrap = false
vim.keymap.set("n", "<C-w>", function()
	vim.opt.wrap = not vim.opt.wrap:get()
end)

-- schedule sync of OS clipboard (it can be slow)
vim.api.nvim_create_autocmd('UIEnter', {
	callback = function()
		vim.o.clipboard = 'unnamedplus'
	end,
})

vim.opt.laststatus = 0
vim.opt.cmdheight = 0
vim.opt.ruler = false

-- Remove netrw
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- lsp
vim.lsp.enable({ 'nil', 'lua_ls', 'rust_analyzer' })
vim.lsp.config('nil', {
	cmd = { "nil" },
	filetypes = { "nix" },
})
vim.lsp.config('rust_analyzer', {
	settings = {
		diagnostics = {
			styleLints = {
				enable = true,
			},
		},
	},
})
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
vim.api.nvim_set_hl(0, "Diagnostic", { fg = "#f38ba8" })
vim.api.nvim_set_hl(0, "Identifier", { fg = "#f9e2af" })
vim.api.nvim_set_hl(0, "@variable", { fg = "#f9a28f" })
vim.api.nvim_set_hl(0, "Comment", { fg = "#6c7086" })
vim.api.nvim_set_hl(0, "Function", { fg = "#89b4fa" })
vim.api.nvim_set_hl(0, "Special", { fg = "#f5c2e7" })
vim.api.nvim_set_hl(0, "String", { fg = "#a6e3a1" })
vim.api.nvim_set_hl(0, "Macro", { fg = "#94e2d5" })
