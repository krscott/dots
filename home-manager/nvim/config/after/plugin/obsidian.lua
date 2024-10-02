local function is_dir(path)
    local stat = vim.loop.fs_stat(path)
    return stat and stat.type == "directory"
end

local function filter_extant_dirs(workspaces)
    local out = {}
    for _, w in ipairs(workspaces) do
        if is_dir(w.path) then
            table.insert(out, w)
        end
    end
    return out
end

local workspaces = filter_extant_dirs({
    {
        name = "notes",
        path = "~/Documents/notes",
    },
})

-- plugin errors on startup if workspaces is empty
if #workspaces > 0 then
    require("obsidian").setup({
        workspaces = workspaces,
        ui = {
            checkboxes = {
                [" "] = { char = "󰄱", hl_group = "ObsidianTodo" },
                ["x"] = { char = "", hl_group = "ObsidianDone" },
            },
        },
    })
end
