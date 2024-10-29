local chatgpt_exists, chatgpt = pcall(require, "chatgpt")
if (chatgpt_exists and os.getenv("KRS_NIX_SECRETS_ENABLE")) then
    -- https://github.com/jackMort/ChatGPT.nvim/blob/main/lua/chatgpt/config.lua
    chatgpt.setup({
        api_key_cmd = "get_openai_api_key",
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
end
