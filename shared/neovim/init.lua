vim.o.expandtab = true
vim.o.smartindent = true
vim.o.tabstop = 4
vim.o.shiftwidth = 4

vim.cmd.colorscheme("tokyonight");

vim.api.nvim_create_autocmd("Filetype", {
    callback = function(args)
        vim.treesitter.start();
    end,
})
