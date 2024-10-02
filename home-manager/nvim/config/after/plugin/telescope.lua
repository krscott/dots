local builtin = require('telescope.builtin')

local function find_files()
    builtin.find_files({
        find_command = { 'rg', '--files', '--hidden', '--glob', '!**/.git/*' }
    })
end

local function find_all_files()
    builtin.find_files({
        find_command = { 'rg', '--files', '--hidden', '--no-ignore', '--glob', '!**/.git/*' }
    })
end

-- vim.keymap.set('n', '<C-p>', builtin.git_files, { desc = "Telescope: Find Files in Git" })
vim.keymap.set('n', '<leader>pf', find_files, { desc = "Find Files" })
vim.keymap.set('n', '<leader>f', find_files, { desc = "Find Files" })
vim.keymap.set('n', '<leader>pF', find_all_files, { desc = "Find All Files" })
vim.keymap.set('n', '<leader>pg', builtin.live_grep, { desc = "Live Grep" })
vim.keymap.set('n', '<leader>pb', builtin.buffers, { desc = "Buffers" })
vim.keymap.set('n', 'gr', ':Telescope lsp_references<CR>', { desc = "Find References (Telescope)" })

vim.keymap.set('n', '<leader>?h', builtin.help_tags, { desc = "Find in help" })
vim.keymap.set('n', '<leader>?k', ':Telescope keymaps<CR>', { desc = "Find Keymaps" })
vim.keymap.set('n', '<leader>?c', ':Telescope commands<CR>', { desc = "Find Commands" })
