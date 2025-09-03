return {
	"nvim-treesitter/nvim-treesitter",
	branch = 'master',
	lazy = false,
	build = ":TSUpdate",
	config = function()
		require("nvim-treesitter.configs").setup({
			ensure_installed = {
				"bash",
				"java",
				"lua",
				"python",
				"rust",
			},
			highlight = { enable = true },
			indent = { enable = true },
		})
	end,
}

