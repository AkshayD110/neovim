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

    -- Picker: files changed on the current branch vs a base branch
    -- (equivalent of `git diff <base> --name-only`)
    local function git_branch_diff(base)
      base = base or 'main'
      local pickers = require('telescope.pickers')
      local finders = require('telescope.finders')
      local conf = require('telescope.config').values

      -- Compare the working tree (including uncommitted changes) against
      -- `base`, i.e. the literal `git diff <base> --name-only`.
      local cmd = { 'git', 'diff', '--name-only', base }

      pickers.new({}, {
        prompt_title = 'Changed vs ' .. base,
        finder = finders.new_oneshot_job(cmd, {}),
        sorter = conf.file_sorter({}),
        previewer = conf.file_previewer({}),
      }):find()
    end

    local U = require('aksh.utils')
    local nmap = U.nmap
    nmap('<leader>ff', '<cmd>Telescope find_files<cr>', { desc = 'Fuzzy find files in cwd' })
    nmap('<leader>fg', '<cmd>Telescope live_grep<cr>', { desc = 'Find text under cwd' })
    nmap('<leader><leader>', '<cmd>Telescope oldfiles<cr>', { desc = 'Find text old files' })
    nmap('<leader>fc', function() git_branch_diff('main') end, { desc = 'Files changed vs main' })
    nmap('<leader>gs', '<cmd>Telescope git_status<cr>', { desc = 'Git status (uncommitted changes)' })
  end,
}
