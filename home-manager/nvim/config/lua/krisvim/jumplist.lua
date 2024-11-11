-- function print_jumplist()
--     local current_win = vim.api.nvim_get_current_win()
--     local jumplist, current_idx = unpack(vim.fn.getjumplist(current_win))

--     for i, jump in pairs(jumplist) do
--         local bufname = vim.api.nvim_buf_get_name(jump.bufnr)
--         print(i - current_idx - 1, bufname, dumps(jump))
--     end
-- end

local function is_valid_jump(bufname)
    if string.find(bufname, "neo%-tree filesystem") then
        return false
    end

    return true
end

local function jump_safe(jumplist, i, current_idx)
    local jump = jumplist[i]
    if jump then
        local bufname = vim.api.nvim_buf_get_name(jump.bufnr)
        if is_valid_jump(bufname) then
            local cmd
            if i > current_idx then
                cmd = tostring(i - current_idx) .. '<C-i>'
            elseif i < current_idx then
                cmd = tostring(current_idx - i) .. '<C-o>'
            else
                error("Cannot jump to current_idx")
            end

            -- Use nvim_feedkeys instead of vim.cmd.normal to avoid infinite recursion
            local keys = vim.api.nvim_replace_termcodes(cmd, true, false, true)
            vim.api.nvim_feedkeys(keys, 'n', true) -- 'n' means do not remap keys

            return true
        end
    end
    return false
end

local function jump_back()
    local current_win = vim.api.nvim_get_current_win()
    local jumplist, current_idx = unpack(vim.fn.getjumplist(current_win))
    -- Adjust for lua table index
    current_idx = current_idx + 1

    -- Start from the current index and move backwards
    for i = current_idx - 1, 1, -1 do
        if jump_safe(jumplist, i, current_idx) then
            break
        end
    end
end

local function jump_forward()
    local current_win = vim.api.nvim_get_current_win()
    local jumplist, current_idx = unpack(vim.fn.getjumplist(current_win))
    -- Adjust for lua table index
    current_idx = current_idx + 1

    -- Start from the current index and move forwards
    for i = current_idx + 1, #jumplist, 1 do
        if jump_safe(jumplist, i, current_idx) then
            break
        end
    end
end

vim.keymap.set('n', '<C-o>', jump_back, { noremap = true, silent = true })
vim.keymap.set('n', '<C-i>', jump_forward, { noremap = true, silent = true })
