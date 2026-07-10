return {
  'stevearc/aerial.nvim',
  dependencies = {
    'nvim-treesitter/nvim-treesitter',
    'nvim-tree/nvim-web-devicons',
  },
  keys = {
    { '<leader>oo', '<cmd>AerialToggle!<cr>', desc = 'Toggle code outline' },
    { '<leader>on', '<cmd>AerialNavToggle<cr>', desc = 'Toggle code outline navigation' },
  },
  opts = {
    backends = { 'treesitter', 'lsp', 'markdown', 'man' },
    layout = {
      min_width = { 40, 0.2 },
      default_direction = 'right',
    },
    attach_mode = 'global',
    filter_kind = false,
    show_guides = true,
    guides = {
      mid_item = '├─',
      last_item = '└─',
      nested_top = '│ ',
      whitespace = '  ',
    },
  },
}
