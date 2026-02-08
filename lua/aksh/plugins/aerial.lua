local U = require('aksh.utils')
return {
  'stevearc/aerial.nvim',
  dependencies = {
    'nvim-treesitter/nvim-treesitter',
    'nvim-tree/nvim-web-devicons',
  },
  opts = {
    backends = { 'treesitter', 'lsp', 'markdown', 'man' },
    layout = {
      min_width = { 40, 0.2 },
    },
    on_attach = function(bufnr)
      U.nmap('<leader>oo', '<cmd>AerialToggle!<cr>', { desc = 'Toggle code outline' })
      U.nmap('<leader>on', '<cmd>AerialNavToggle<cr>', { desc = 'Toggle code outline' })
    end,
  },
  config = true,
}
