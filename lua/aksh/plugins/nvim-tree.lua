local U = require('aksh.utils')
return {
  'nvim-tree/nvim-tree.lua',
  dependencies = { 'nvim-tree/nvim-web-devicons', },
  config = function()
    local nvimtree = require('nvim-tree')
    vim.g.loaded_netrw = 1
    vim.g.loaded_netrwPlugin = 1

    vim.cmd([[ highlight NvimTreeFolderArrowClosed guifg=#3FC5FF ]])
    vim.cmd([[ highlight NvimTreeFolderArrowOpen guifg=#3FC5FF ]])

    nvimtree.setup({
      view = {
        width = 35,
        relativenumber = true,
      },
      renderer = {
        indent_markers = {
          enable = true,
        },
        icons = {
          glyphs = {
            folder = {
            },
          },
        },
      },
      actions = {
        open_file = {
          window_picker = {
            enable = false,
          },
        },
      },
      filters = {
        custom = {
          '.DS_Store',
          '.idea$',
          '.vscode',
          'node_modules',
          '.cache',
          'build',
          'dist',
          '^target$',
          '__pycache__',
          '.git$',
          'CMakeFiles',
          'CMakeCache.txt',
          '*.iml',
          '*.cmake',
          '.circleci',
          '.github',
          '*.a',
          '*.dylib',
          '*.jar',
        },
      },
      git = {
        ignore = false,
      },
    })

    U.nmap('<leader>ee', '<cmd>NvimTreeToggle<cr>', { desc = 'Toggle file explorer' })
    U.nmap('<leader>ef', '<cmd>NvimTreeFindFileToggle<cr>', { desc = 'Toggle file explorer on current file' })
  end
}
