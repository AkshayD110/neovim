return {
  'nvim-telescope/telescope.nvim',
  dependencies = {
    'nvim-lua/plenary.nvim',
    { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make', },
    'nvim-tree/nvim-web-devicons',
  },
  config = function()
    local telescope = require('telescope')
    local actions = require('telescope.actions')
    
    -- Set quickfix window height when it opens
    vim.api.nvim_create_autocmd('FileType', {
      pattern = 'qf',
      callback = function()
        vim.cmd('resize 10')
      end,
    })

    telescope.setup({
      defaults = {
        path_display = { 'truncate' },
        mappings = {
          i = {
            ["<C-k>"] = actions.move_selection_previous, -- move to prev result
            ["<C-j>"] = actions.move_selection_next, -- move to next result
            ["<C-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
          }
        },
      },
    })
    telescope.load_extension('fzf')

    local U = require('aksh.utils')
    local nmap = U.nmap
    nmap('<leader>ff', '<cmd>Telescope find_files<cr>', { desc = 'Fuzzy find files in cwd' })
    nmap('<leader>fg', '<cmd>Telescope live_grep<cr>', { desc = 'Find text under cwd' })
    nmap('<leader><leader>', '<cmd>Telescope oldfiles<cr>', { desc = 'Find text old files' })
  end,
}
