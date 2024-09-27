-- see also: lsp-zero.lua

-- local function debug_message(msg)
--     vim.api.nvim_echo({ { msg, 'Normal' } }, false, {})
-- end

local function is_cusor_at_beginning_of_line()
    -- Check if the cursor is at the beginning of the line or only whitespace is to the left
    local line = vim.api.nvim_get_current_line()
    local col = vim.fn.col('.') - 1 -- Adjust because col('.') returns 1-indexed value
    local line_to_cursor = line:sub(1, col)

    return col == 0 or line_to_cursor:match("^%s*$")
end

local luasnip = require("luasnip")
local cmp = require("cmp")

cmp.setup({
    completion = {
        -- Auto-select first item in completion menu
        completeopt = 'menu,menuone,noinsert',
    },
    snippet = {
        -- REQUIRED - you must specify a snippet engine
        expand = function(args)
            -- vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
            require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
            -- require('snippy').expand_snippet(args.body) -- For `snippy` users.
            -- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
            -- vim.snippet.expand(args.body) -- For native neovim snippets (Neovim v0.10+)
        end,
    },
    window = {
        -- completion = cmp.config.window.bordered(),
        -- documentation = cmp.config.window.bordered(),
    },
    mapping = cmp.mapping.preset.insert({
        -- Tab key to confirm completion or jump to next snippet field
        ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.confirm()

                -- If this is done on same step, it deletes end paren.
                -- So, delay by a tick
                if luasnip.locally_jumpable(1) then
                    vim.defer_fn(function() luasnip.jump(1) end, 0)
                end
            elseif is_cusor_at_beginning_of_line() then
                -- TODO Should I send a <Tab> here instead of calling fallback?
                fallback()
            elseif luasnip.expand_or_locally_jumpable() then
                luasnip.expand_or_jump()
                -- elseif vim.fn.pumvisible() == 1 then
                --   feedkey("<C-n>")
            else
                fallback()
            end
        end, { "i", "s" }),
        -- Shift+Tab to jump to previous snippet field
        ["<S-Tab>"] = cmp.mapping(function(fallback)
            if luasnip.locally_jumpable(-1) then
                luasnip.jump(-1)
            else
                fallback()
            end
        end, { "i", "s" }),

        -- Ctrl+Space to trigger completion menu
        ['<C-Space>'] = cmp.mapping.complete(),

        -- Scroll up and down in the completion documentation
        ['<C-b>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),

        -- Cancel
        ['<C-e>'] = cmp.mapping.abort(),

        -- Accept currently selected item.
        -- Set `select` to `false` to only confirm explicitly selected items.
        -- ['<CR>'] = cmp.mapping.confirm({ select = true }),
    }),
    sources = cmp.config.sources({
        { name = 'nvim_lsp' },
        -- { name = 'vsnip' },   -- For vsnip users.
        { name = 'luasnip' }, -- For luasnip users.
        -- { name = 'ultisnips' }, -- For ultisnips users.
        -- { name = 'snippy' }, -- For snippy users.
        { name = 'otter' },
    }, {
        { name = 'buffer' },
    })
})

-- Set configuration for specific filetype.
cmp.setup.filetype('gitcommit', {
    sources = cmp.config.sources({
        { name = 'git' }, -- You can specify the `git` source if [you were installed it](https://github.com/petertriho/cmp-git).
    }, {
        { name = 'buffer' },
    })
})

-- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline({ '/', '?' }, {
    mapping = cmp.mapping.preset.cmdline(),
    sources = {
        { name = 'buffer' }
    }
})

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(':', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({
        { name = 'path' }
    }, {
        { name = 'cmdline' }
    }),
    matching = { disallow_symbol_nonprefix_matching = false }
})
