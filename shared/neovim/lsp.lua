local lsps = {
    { 'lua_ls',               {} },
    { 'nil_ls',               {} },
    { 'java-language-server', {} },
}

for _, pair in pairs(lsps) do
    local name, config = pair[1], pair[2]
    vim.lsp.enable(name);
    if config then
        vim.lsp.config(name, config);
    end
end

-- auto format on save
vim.api.nvim_create_autocmd("BufWritePre", {
    callback = function(args)
        vim.lsp.buf.format()
    end
})
