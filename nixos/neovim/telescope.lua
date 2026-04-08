local builtin = require 'telescope.builtin'
vim.keymap.set("n", "<leader>f", builtin.find_files, {})
vim.keymap.set("n", "<leader>gf", builtin.git_files, {})
vim.keymap.set("n", "<leader>g", function()
    builtin.live_grep({ search = vim.fn.input("Grep > ") })
end)
