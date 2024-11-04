-- Use // comments
vim.cmd [[setlocal commentstring=//\ %s]]


-- Go to .h/.c file
local function switch_c_h()
    local current_file = vim.api.nvim_buf_get_name(0)
    local file_name = current_file:match("^.+/(.+)%..+$")
    local ext = current_file:match(".+%.(%w+)$")

    if ext ~= "c" and ext ~= "h" then
        print("Current file is not a .c or .h file")
        return
    end

    local switch_ext = ext == "c" and "h" or "c"
    local same_dir_file = current_file:gsub("%." .. ext .. "$", "." .. switch_ext)

    -- Check if the file is in the same directory first
    if vim.fn.filereadable(same_dir_file) == 1 then
        vim.cmd('edit ' .. same_dir_file)
        return
    end

    -- If not, search the entire project
    -- (Is there a way to use project root?)
    local root_dir = vim.fn.getcwd()
    local find_command = string.format("find %s -type f -name '%s.%s'", root_dir, file_name, switch_ext)

    local handle = io.popen(find_command)
    if handle == nil then
        print("Could not run cmd: " .. find_command)
        return
    end
    local result = handle:read("*a")
    handle:close()

    local files = {}
    for s in result:gmatch("[^\r\n]+") do
        table.insert(files, s)
    end

    if #files == 0 then
        print("No corresponding ." .. switch_ext .. " file found in the project")
        return
    end

    if #files == 1 then
        vim.cmd('edit ' .. files[1])
        return
    end

    local current_dir = vim.fn.expand('%:p:h') .. '/'
    local file_in_same_dir = nil
    for _, file in ipairs(files) do
        if file:match('^' .. current_dir) then
            file_in_same_dir = file
            break
        end
    end

    if file_in_same_dir then
        vim.cmd('edit ' .. file_in_same_dir)
        return
    end

    -- Ask user to select file
    print("Multiple files found:")
    for i, file in ipairs(files) do
        print(i .. ": " .. file)
    end
    local choice = vim.fn.input("Enter file number to open: ")
    local file_num = tonumber(choice)
    if file_num and file_num >= 1 and file_num <= #files then
        vim.cmd('edit ' .. files[file_num])
    else
        print("Invalid selection")
    end
end

-- Register the function in Neovim
local switch_c_h_cmd = "SwitchCH"
vim.api.nvim_create_user_command(switch_c_h_cmd, switch_c_h, {})

vim.keymap.set(
    "n",
    "gh",
    "<cmd>" .. switch_c_h_cmd .. "<cr>",
    { desc = "Go to .h/.c" }
)

-- Replace

vim.keymap.set(
    { "n", "v" },
    "<leader>re",
    [[:s/\v(\s*)(\w*)( =.*)?,/\1case \2:]],
    { desc = "enum const -> case" }
)
