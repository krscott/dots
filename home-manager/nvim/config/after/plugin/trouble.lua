local wk_exists, wk = pcall(require, 'which-key')
if (wk_exists) then
    wk.add({
        { "<leader>x", group = "trouble" },
    })
end

local trouble = require("trouble")

trouble.setup({})

vim.keymap.set("n", "<leader>xx",
    "<cmd>Trouble close<cr>",
    { desc = "Trouble: Close" }
)
vim.keymap.set("n", "<leader>xd",
    "<cmd>Trouble diagnostics toggle<cr>",
    { desc = "Trouble: Diagnostics" }
)
vim.keymap.set("n", "<leader>cs",
    "<cmd>Trouble symbols toggle win.position=left<cr>",
    { desc = "Trouble: Symbols" }
)
vim.keymap.set("n", "<leader>cl",
    "<cmd>Trouble lsp toggle win.position=left<cr>",
    { desc = "Trouble: LSP Definitions" }
)
vim.keymap.set("n", "<leader>xq",
    "<cmd>Trouble qflist toggle<cr>",
    { desc = "Trouble: Quickfix" }
)
vim.keymap.set("n", "<leader>xl",
    "<cmd>Trouble loclist toggle<cr>",
    { desc = "Trouble: Location List" }
)
vim.keymap.set("n", "gR",
    "<cmd>Trouble lsp_references<cr>",
    { desc = "Trouble: LSP References" }
)
vim.keymap.set("n", "gD",
    "<cmd>Trouble lsp_definitions<cr>",
    { desc = "Trouble: LSP Definitions" }
)
