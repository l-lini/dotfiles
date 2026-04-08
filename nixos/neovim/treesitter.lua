vim.api.nvim_create_autocmd("Filetype", {
    callback = function(args)
        local ok = pcall(vim.treesitter.start, args.buf)
    end,
})
