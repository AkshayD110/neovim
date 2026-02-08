local o = vim.o
local g = vim.g

o.termguicolors = true
o.background = 'dark'
o.number = true
o.cursorline = true
o.tabstop = 2
o.expandtab = true
o.cindent = true
o.shiftwidth = 2
o.swapfile = false

g.mapleader = ' '

vim.cmd('syntax on')
