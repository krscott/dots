-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

--@param index integer
local function goto_buffer_cmd(index)
  return function()
    vim.cmd("bf")
    for _ = 2, index do
      vim.cmd("bn")
    end
  end
end

for i = 1, 9 do
  vim.keymap.set("n", "<leader>" .. i, goto_buffer_cmd(i), { desc = "Buffer " .. i })
end
