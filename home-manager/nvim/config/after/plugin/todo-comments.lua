local todo_comments = require("todo-comments")

todo_comments.setup({
    highlight = {
        -- vimgrep regex, supporting the pattern T*DO(name)
        pattern = [[.*<((KEYWORDS)%(\(.{-1,}\))?):?]],
    },
    search = {
        -- ripgrep regex, supporting the pattern T*DO(name)
        pattern = [[\b(KEYWORDS)(\(\w*\))*\b]],
    }
})

vim.keymap.set("n", "]t", todo_comments.jump_next, { desc = "Next todo comment" })
vim.keymap.set("n", "[t", todo_comments.jump_prev, { desc = "Previous todo comment" })
vim.keymap.set("n", "<leader>pt", "<cmd>TodoTelescope<cr>", { desc = "Find TODOs" })
vim.keymap.set("n", "<leader>xt", "<cmd>TodoTrouble<cr>", { desc = "Find TODOs" })
