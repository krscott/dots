vim.g.mapleader = " "

-- Fix smartindent putting '#' on column 0
vim.keymap.set("i", "#", "X<C-h>#")
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex, { desc = "View Files" })

-- Alt-J/K to move selection
vim.keymap.set("v", "<M-j>", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "<M-k>", ":m '<-2<CR>gv=gv")

-- Use tab/shift+tab to indent/dedent in Visual mode
vim.keymap.set("v", "<Tab>", ">gv")
vim.keymap.set("v", "<S-Tab>", "<gv")

-- Keep cursor in-place when removing newline
-- vim.keymap.set("n", "J", "mzJ`z")

-- Keep cursor in center of screen when paging
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")

-- Keep cursor in-place when yanking
vim.keymap.set("v", "y", "myy`y")
vim.keymap.set("v", "Y", "myY`y")

-- Delete to void register
vim.keymap.set("x", "<leader>vp", "\"_dP")
vim.keymap.set("n", "<leader>vd", "\"_d")
vim.keymap.set("v", "<leader>vd", "\"_d")

-- Yank into system clipboard
vim.keymap.set("n", "<leader>y", "\"+y", { desc = "Yank to clipboard" })
vim.keymap.set("v", "<leader>y", "\"+y", { desc = "Yank to clipboard" })
vim.keymap.set("n", "<leader>Y", "\"+Y", { desc = "Yank line to clipboard" })

-- Temporarily disable highlight
vim.keymap.set("n", "<Esc>", "<cmd>noh<cr>")
vim.keymap.set("n", "<C-c>", "<cmd>noh<cr>")

-- Find/replace
vim.keymap.set(
    "n",
    "<leader>s",
    [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]],
    { desc = "Replace word" }
)
vim.keymap.set(
    "v",
    "<leader>s",
    [[y:%s/<C-r>"/<C-r>"/gI<Left><Left><Left>]],
    { desc = "Replace selection" }
)
vim.keymap.set(
    "n",
    "<leader>S",
    [[yiwgv:s/\<<C-r>"\>/<C-r>"/gI<Left><Left><Left>]],
    { desc = "Replace word in last selection" }
)
vim.keymap.set(
    { "n", "v" },
    "<leader>rk",
    [[:s/\(.*\)<Left><Left><Left><Left><Left><Left>]],
    { desc = "One eye kirby" }
)

-- Cringe
vim.keymap.set("i", "<C-c>", "<Esc>")
vim.keymap.set("n", "Q", "<nop>")

-- Tabs/Spaces
vim.keymap.set("n",
    "<leader>c2",
    "<cmd>set tabstop=2 shiftwidth=2 expandtab<cr><cmd>retab<cr>",
    { desc = "Set tab to 2 spaces" }
)
vim.keymap.set("n",
    "<leader>c4",
    "<cmd>set tabstop=4 shiftwidth=4 expandtab<cr><cmd>retab<cr>",
    { desc = "Set tab to 4 spaces" }
)

-- To-do comments
local todo_user = os.getenv("TODO_USER") or "kscott"

vim.keymap.set(
    "n",
    "<leader>ct",
    "OTODO(" .. todo_user .. "): <esc><cmd>Commentary<cr>A",
    { desc = "Insert TODO" }
)

vim.keymap.set(
    "n",
    "<leader>pm",
    "<cmd>lua require('telescope.builtin').live_grep()<cr>TODO\\(" .. todo_user .. "\\)",
    { desc = "Find my TODOs" }
)

-- Restart LSP
vim.keymap.set("n", "<leader>cr", "<cmd>LspRestart<cr>", { desc = "Restart LSP" })


-- Table Format
vim.keymap.set(
    "v",
    "<leader>rt",
    "<esc><cmd>'<,'>s/\\s*,\\s*/, /g<cr><cmd>'<,'>!column -t -s ',' -o ','<cr><cmd>'<,'>s/\\(\\s*\\),/,\\1/g<cr><cmd>'<,'>s/\\s*$//<cr>",
    { desc = "Format Table" }
)
