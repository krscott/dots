local chatgpt = require("chatgpt")

-- https://github.com/jackMort/ChatGPT.nvim/blob/main/lua/chatgpt/config.lua
chatgpt.setup({
    -- popup_input = {
    --     submit = "<CR>"
    -- },
    edit_with_instructions = {
        keymaps = {
            use_output_as_input = "<C-s>",
        },
    }
})

local wk_exists, wk = pcall(require, 'which-key')
if (wk_exists) then
    wk.add({
        { "<leader>c", group = "ChatGPT", mode = "v" },
        {
            "<leader>ce",
            function()
                chatgpt.edit_with_instructions()
            end
            ,
            desc = "Edit with instructions",
            mode = "v"
        },
    })
end
