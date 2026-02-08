vim.loader.enable()
vim.opt.conceallevel = 1

require('aksh.settings')
require('aksh.lazy')
require('aksh.keymap')

vim.cmd[[colorscheme lunaperche]]
