return {
  {
    'nvim-treesitter/nvim-treesitter',
    event = { 'BufReadPre', 'BufNewFile' },
    build = ':TSUpdate',
    dependencies = {
      'nvim-treesitter/nvim-treesitter-textobjects',
    },
    config = function()
      local configs = require('nvim-treesitter.configs')
      configs.setup({
        auto_install = true,
        ignore_install = {},
        modules = {},
        ensure_installed = {
          'json',
          'javascript',
          'typescript',
          'tsx',
          'yaml',
          'html',
          'css',
          'markdown',
          'markdown_inline',
          'bash',
          'dockerfile',
          'gitignore',
          'c',
          'cpp',
          'cuda',
          'java',
          'kotlin',
          'clojure',
          'lua',
          'vim',
          'make',
          'org',
          'python',
          'regex',
          'rust',
          'sql',
          'toml',
        },
        indent = { enable = true },
        highlight = { 
          enable = true,
          additional_vim_regex_highlighting = false,
        },
        textobjects = {
          select = {
            enable = true,
            lookahead = true,
            keymaps = {
              ["fa"] = "@function.outer",
              ["ca"] = "@class.outer",
            },
            include_surrounding_whitespace = { ['@function.inner'] = false, ['class'] = false },
          },
          lsp_interop = {
            enable = true,
            border = 'none',
            peek_definition_code = {
              ["<leader>df"] = "@function.outer",
              ["<leader>dF"] = "@class.outer",
            },
            floating_preview_opts = {
            },
          },
        },
        incremental_selection = {
          enable = true,
          keymaps = {
            init_selection = '<c-cr>',
            scope_incremental = '<cr>',
            node_incremental = '<tab>',
            node_decremental = '<s-tab>',
          },
        },
      })
    end
  }
}
