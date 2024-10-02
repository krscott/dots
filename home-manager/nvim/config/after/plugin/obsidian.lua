require("obsidian").setup({
    workspaces = {
        {
            name = "notes",
            path = "~/Documents/notes",
        },
    },
    ui = {
        checkboxes = {
            [" "] = { char = "󰄱", hl_group = "ObsidianTodo" },
            ["x"] = { char = "", hl_group = "ObsidianDone" },
        },
    },
})
