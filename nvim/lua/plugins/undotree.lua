return {
	"mbbill/undotree",
	config = function() 
		vim.opt.undofile = true
		vim.opt.undodir = vim.fn.expand("~/.local/share/nvim/undo")
		vim.keymap.set("n", "<leader>u", vim.cmd.UndotreeToggle)
	end
}
