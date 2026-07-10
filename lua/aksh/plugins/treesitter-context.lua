return {
  'nvim-treesitter/nvim-treesitter-context',
  event = { 'BufReadPre', 'BufNewFile' },
  config = function()
    require('treesitter-context').setup({
      enable = true,
      max_lines = 3,
      trim_scope = 'outer',
      mode = 'cursor',
    })
  end
}
