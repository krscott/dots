local wk_exists, wk = pcall(require, 'which-key')
if (wk_exists) then
    wk.add({
        { "<leader>d",  group = "debug" },
        { "<leader>db", group = "breakpoints" },
        { "<leader>dh", group = "hover" },
        { "<leader>dr", group = "repl" },
        { "<leader>ds", group = "step" },
        { "<leader>du", group = "ui" },
    })
end

require('overseer').setup()

local dap = require('dap')
local dapui = require('dapui')
dapui.setup()

dap.listeners.before.attach.dapui_config = function()
    dapui.open()
end
dap.listeners.before.launch.dapui_config = function()
    dapui.open()
end
dap.listeners.before.event_terminated.dapui_config = function()
    dapui.close()
end
dap.listeners.before.event_exited.dapui_config = function()
    dapui.close()
end

vim.keymap.set('n', '<F7>', dapui.toggle, { desc = 'DAP: Toggle UI' })
vim.keymap.set('n', '<F8>', dap.toggle_breakpoint, { desc = 'DAP: Toggle Breakpoint' })

vim.keymap.set('n', '<F6>', dap.continue, { desc = 'DAP: Continue' })
vim.keymap.set('n', '<F9>', dap.step_out, { desc = 'DAP: Step Out' })
vim.keymap.set('n', '<F10>', dap.step_over, { desc = 'DAP: Step Over' })
vim.keymap.set('n', '<F11>', dap.step_into, { desc = 'DAP: Step Into' })

vim.keymap.set('n', '<leader>dsc', dap.continue, { desc = 'DAP: Continue (F6)' })
vim.keymap.set('n', '<leader>dso', dap.step_out, { desc = 'DAP: Step Out (F9)' })
vim.keymap.set('n', '<leader>dsv', dap.step_over, { desc = 'DAP: Step Over (F10)' })
vim.keymap.set('n', '<leader>dsi', dap.step_into, { desc = 'DAP: Step Into (F11)' })

vim.keymap.set('n', '<leader>dbc', function()
    dap.set_breakpoint(vim.fn.input('Breakpoint condition: '))
end, { desc = 'DAP: Breakpoint Condition' })
vim.keymap.set('n', '<leader>dbm', function()
    dap.set_breakpoint({ nil, nil, vim.fn.input('Log point message: ') })
end, { desc = 'DAP: Log Point Message' })
vim.keymap.set('n', '<leader>dbt', dap.toggle_breakpoint, { desc = 'DAP: Toggle Breakpoint (F8)' })

vim.keymap.set('n', '<leader>dc', dap.run_to_cursor, { desc = 'DAP: Run to Cursor' })

-- Adapters

dap.adapters.gdb = {
    name = "gdb",
    type = "executable",
    command = "gdb",
    args = { "-i", "dap" },
}
dap.adapters.lldb = {
    name = "lldb",
    type = "executable",
    command = "lldb",
}

-- dap.configurations.c = {
--     {
--         name = "Launch",
--         type = "gdb",
--         request = "launch",
--         program = function()
--             return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
--         end,
--         cwd = "${workspaceFolder}",
--         stopAtBeginningOfMainSubprogram = false,
--         args = function()
--             local args = {}
--             while true do
--                 local arg = vim.fn.input('Arg (empty to stop): ')
--                 if string.len(arg) == 0 then
--                     break
--                 end
--                 table.insert(args, arg)
--             end
--             return args
--         end,
--     },
-- }
