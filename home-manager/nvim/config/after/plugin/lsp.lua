local neodev_exists, neodev = pcall(require, 'neodev')
if (neodev_exists) then
  neodev.setup({
    library = { plugins = { "nvim-dap-ui" }, types = true },
  })
end

local lsp = require('lspconfig')
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

local defaults = { capabilities = capabilities }

local function with_defaults(settings)
  for k, v in pairs(defaults) do
    if settings[k] == nil then
      settings[k] = v
    end
  end
  return settings
end

lsp.bashls.setup(defaults)

lsp.clangd.setup(with_defaults {
  -- https://old.reddit.com/r/neovim/comments/12qbcua/multiple_different_client_offset_encodings/jgpqxsp/
  cmd = {
    "clangd",
    "--offset-encoding=utf-16",
  }
})

lsp.cssls.setup(defaults)

lsp.eslint.setup(with_defaults {
  on_attach = function(_ --[[client]], bufnr)
    -- Format document on save
    vim.api.nvim_create_autocmd("BufWritePre", {
      buffer = bufnr,
      command = "EslintFixAll",
    })
  end,
})

lsp.gleam.setup(defaults)
lsp.golangci_lint_ls.setup(defaults)
lsp.gopls.setup(defaults)
lsp.html.setup(defaults)
lsp.jsonls.setup(defaults)

lsp.lua_ls.setup(with_defaults {
  -- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#lua_ls
  on_init = function(client)
    local path = client.workspace_folders[1].name
    if not vim.loop.fs_stat(path .. '/.luarc.json') and not vim.loop.fs_stat(path .. '/.luarc.jsonc') then
      client.config.settings = vim.tbl_deep_extend('force', client.config.settings, {
        Lua = {
          runtime = {
            -- Tell the language server which version of Lua you're using
            -- (most likely LuaJIT in the case of Neovim)
            version = 'LuaJIT'
          },
          -- Make the server aware of Neovim runtime files
          workspace = {
            checkThirdParty = false,
            library = {
              vim.env.VIMRUNTIME
              -- Depending on the usage, you might want to add additional paths here.
              -- E.g.: For using `vim.*` functions, add vim.env.VIMRUNTIME/lua.
              -- "${3rd}/luv/library"
              -- "${3rd}/busted/library",
            }
            -- or pull in all of 'runtimepath'. NOTE: this is a lot slower
            -- library = vim.api.nvim_get_runtime_file("", true)
          }
        }
      })
    end
    return true
  end,
  settings = {
    Lua = {
      diagnostics = {
        globals = { 'vim' }
      }
    }
  }
})

lsp.nil_ls.setup(with_defaults {
  settings = {
    ['nil'] = {
      formatting = {
        command = { "nix-any-fmt" },
      },
    },
  },
})

lsp.pyright.setup(with_defaults {
  settings = {
    pyright = {
      disableOrganizeImports = true, -- Using Ruff
    },
    python = {
      analysis = {
        typeCheckingMode = 'strict',
      },
    },
  },
})
lsp.ruff_lsp.setup(defaults)
--lsp.rust_analyzer.setup(defaults) -- handled by rustaceanvim
lsp.ts_ls.setup(defaults)


-- Formatter shims
local lsp_format = require("lsp-format")
lsp_format.setup({})
vim.cmd [[cabbrev wq execute "Format sync" <bar> wq]]

-- Examples: https://github.com/creativenull/efmls-configs-nvim
-- TODO: Pull from nixpkgs/package/vimPlugins.efmls-configs-nvim directly?
lsp.efm.setup {
  init_options = { documentFormatting = true },
  settings = {
    rootMarkers = { ".git/", "pyproject.toml" },
    languages = {
      -- python = { { formatCommand = "black -", formatStdin = true }, },
      sh = { { formatCommand = "shfmt -ci -s -bn", formatStdin = true }, },
      -- nix = { { formatCommand = "alejandra -qq", formatStdin = true }, },
    }
  },
  on_attach = lsp_format.on_attach,
}


-- Keymaps
-- TODO: https://github.com/neovim/nvim-lspconfig#suggested-configuration

-- Code actions
vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, { desc = "Code Action" })
