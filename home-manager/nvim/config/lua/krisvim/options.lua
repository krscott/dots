local opt = vim.opt

local config_dir =
    (os.getenv("XDG_CONFIG_HOME") or (os.getenv("HOME") .. "/.config"))
    .. "/vim"

-- Colors
opt.termguicolors = true
opt.colorcolumn = "80"

-- Hide startup screen
opt.shortmess = "I"

-- Indents
opt.autoindent = true
opt.expandtab = true -- Use spaces instead of tabs
opt.shiftround = true
opt.shiftwidth = 4
opt.smartindent = false
opt.tabstop = 4

-- Line numbers
opt.number = true
opt.relativenumber = true

-- Scroll
opt.scrolloff = 8
opt.signcolumn = "yes"

-- Search
opt.incsearch = true  -- Find the next match as we type
opt.hlsearch = true   -- Highlight searches
opt.ignorecase = true -- Ignore case when searching...
opt.smartcase = true  -- ...unless we type a capital

-- Undo
opt.swapfile = false
opt.backup = false
opt.undodir = config_dir .. "/undodir"
opt.undofile = true

-- Updates
opt.updatetime = 50

-- Suppress hit-enter prompts
opt.shortmess = {
    o = true
}
