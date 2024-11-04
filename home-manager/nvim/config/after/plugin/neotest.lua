require("neotest").setup({
    adapters = {
        require("neotest-gtest").setup({
            debug_adapter = "gdb",
        }),
    },
})
