local neotest = require("neotest")

neotest.setup({
    adapters = {
        require("neotest-gtest").setup({
            debug_adapter = "gdb",
        }),
    },
})

local wk_exists, wk = pcall(require, 'which-key')
if (wk_exists) then
    wk.add({
        { "<leader>dt", group = "neotest" },
    })
end

vim.keymap.set(
    "n",
    "<leader>dtn",
    neotest.run.run,
    { desc = "neotest: Run nearest test" }
)
vim.keymap.set(
    "n",
    "<leader>dto",
    neotest.summary.open,
    { desc = "neotest: Open Summary" }
)
vim.keymap.set(
    "n",
    "<leader>dtc",
    "<cmd>ConfigureGtest<cr>",
    { desc = "neotest-gtest: Configure" }
)
