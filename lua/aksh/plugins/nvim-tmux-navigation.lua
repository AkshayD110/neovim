return {
 'alexghergh/nvim-tmux-navigation',
    config = function()
      require('nvim-tmux-navigation').setup({
        disable_when_zoomed = false, -- adjust this option as needed
      })

      -- Key mappings for tmux navigation
      vim.keymap.set('n', '<C-h>', function() require('nvim-tmux-navigation').NvimTmuxNavigateLeft() end, { noremap = true, silent = true })
      vim.keymap.set('n', '<C-j>', function() require('nvim-tmux-navigation').NvimTmuxNavigateDown() end, { noremap = true, silent = true })
      vim.keymap.set('n', '<C-k>', function() require('nvim-tmux-navigation').NvimTmuxNavigateUp() end, { noremap = true, silent = true })
      vim.keymap.set('n', '<C-l>', function() require('nvim-tmux-navigation').NvimTmuxNavigateRight() end, { noremap = true, silent = true })
      vim.keymap.set('n', '<C-\\>', function() require('nvim-tmux-navigation').NvimTmuxNavigateLastActive() end, { noremap = true, silent = true })
      vim.keymap.set('n', '<C-Space>', function() require('nvim-tmux-navigation').NvimTmuxNavigateNext() end, { noremap = true, silent = true })
    end,
}
