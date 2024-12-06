-- TODO: How to determine if asm file is nasm or other asm?
vim.cmd("syntax on")
vim.bo.ft = "nasm"

vim.cmd [[setlocal commentstring=;\ %s]]
