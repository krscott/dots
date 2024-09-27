local wk = require('which-key')

wk.add({
    { "<leader>c", group = "code" },
    { "<leader>g", group = "git" },
    { "<leader>p", group = "project" },
    { "<leader>v", group = "void-register" },
    { "<leader>?", group = "help" },
})

wk.add({
    { "<leader>v", group = "void-register", mode = "v" },
})

vim.o.timeout = true
vim.o.timeoutlen = 300
