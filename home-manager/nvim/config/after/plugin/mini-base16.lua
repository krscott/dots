local status, minibase16 = pcall(require, "mini.base16")
if (status) then
    minibase16.setup({
        palette = {
            base00 = os.getenv("STYLIX_BASE00"),
            base01 = os.getenv("STYLIX_BASE01"),
            base02 = os.getenv("STYLIX_BASE02"),
            base03 = os.getenv("STYLIX_BASE03"),
            base04 = os.getenv("STYLIX_BASE04"),
            base05 = os.getenv("STYLIX_BASE05"),
            base06 = os.getenv("STYLIX_BASE06"),
            base07 = os.getenv("STYLIX_BASE07"),
            base08 = os.getenv("STYLIX_BASE08"),
            base09 = os.getenv("STYLIX_BASE09"),
            base0A = os.getenv("STYLIX_BASE0A"),
            base0B = os.getenv("STYLIX_BASE0B"),
            base0C = os.getenv("STYLIX_BASE0C"),
            base0D = os.getenv("STYLIX_BASE0D"),
            base0E = os.getenv("STYLIX_BASE0E"),
            base0F = os.getenv("STYLIX_BASE0F"),
        },
    })

    -- transparent.nvim
    local transparent = require("transparent")
    transparent.setup({
        extra_groups = {
            "FloatBorder",
            "NormalFloat",
        },
        on_clear = function()
            transparent.clear_prefix("Line")
            transparent.clear_prefix("trouble")
            transparent.clear_prefix("DiagnosticFloating")
            transparent.clear_prefix("NeoTree")
            transparent.clear_prefix("WhichKey")
        end
    })
    vim.cmd("TransparentEnable")
end
