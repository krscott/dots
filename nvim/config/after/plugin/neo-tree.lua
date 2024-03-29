-- https://github.com/nvim-neo-tree/neo-tree.nvim/

require('neo-tree').setup({
    close_if_last_window = true,
    filesystem = {
        filtered_items = {
            hide_dotfiles = false,
            hide_by_name = {
                ".git",
            },
            never_show = {
                ".git",
            },
        },
    },
    window = {
        width = 30,
    }
})

vim.fn.sign_define("DiagnosticSignError",
    { text = " ", texthl = "DiagnosticSignError" })
vim.fn.sign_define("DiagnosticSignWarn",
    { text = " ", texthl = "DiagnosticSignWarn" })
vim.fn.sign_define("DiagnosticSignInfo",
    { text = " ", texthl = "DiagnosticSignInfo" })
vim.fn.sign_define("DiagnosticSignHint",
    { text = "󰌵", texthl = "DiagnosticSignHint" })

vim.keymap.set('n', '<leader>e', '<cmd>Neotree toggle reveal<cr>',
    { desc = "Neotree" })
