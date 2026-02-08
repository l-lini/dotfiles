local lsps = {
    { 'lua_ls',               {} },
    { 'nil_ls',               {} },
    { 'java-language-server', {} },
    { 'asm-lsp',              {} },
    { 'ccls',                 {} },
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

-- cmp stuffs
local cmp = require 'cmp'
cmp.setup({
    snippet = {
        expand = function(args)
            require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
        end,
    },
    mapping = cmp.mapping.preset.insert({
        ['<C-b>'] = cmp.mapping.select_prev_item(),
        ['<C-f>'] = cmp.mapping.select_next_item(),
        ['<C-y>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
    }),
    sources = cmp.config.sources({
        { name = 'nvim_lsp' },
        { name = 'luasnip' },
    }, {
        { name = 'buffer' },
    })
})

-- lsp stuffs TODO fix
vim.keymap.set("n", "<leader>d", function() vim.diagnostic.open_float() end)
