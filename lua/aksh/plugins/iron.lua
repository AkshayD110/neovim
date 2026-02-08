return {
  'Vigemus/iron.nvim',
  config = function()
    local iron = require('iron.core')
    local view = require('iron.view')
    iron.setup({
      config = {
        scratch_repl = true,
        repl_definition = {
          sh = {
            command = { 'zsh' },
          },
          python = {
            command = { 'python' },
          },
        },
        repl_open_cmd = view.split.vertical.botright(50),
      },
      include_surrounding_whitespace = true,
      keymaps = {
        clear = '<leader>ll',
        cr = '<leader>l<cr>',
        visual_send = '<leader>sc',
      },
    })
  end,
}
