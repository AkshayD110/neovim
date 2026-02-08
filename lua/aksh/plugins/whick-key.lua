return {
  'folke/which-key.nvim',
  event = 'VeryLazy',
  init = function()
    vim.o.timeout = true
    vim.o.timeoutlen = 500
  end,
  -- Keep opts minimal to avoid deprecation warnings on which-key v3
  opts = {},
  config = function(_, opts)
    local ok, wk = pcall(require, 'which-key')
    if not ok then return end
    wk.setup(opts)

    -- Group labels so which-key shows names instead of "+N keymaps"
    local groups = {
      { '<leader>e', group = 'Explorer' },
      { '<leader>f', group = 'Find' },
      { '<leader>t', group = 'Terminal/Tab' },
      { '<leader>l', group = 'REPL' },
      { '<leader>w', group = 'Workspace' },
      { '<leader>s', group = 'Splits' },
      { '<leader>o', group = 'Outline' },
      { '<leader>b', group = 'Brain/Notes' },
      { '<leader>p', group = 'Pomodoro' },
      { '<leader>d', group = 'Definitions' },
      { '<leader>j', group = 'Jira' },
      { 'g',          group = 'LSP/Go', mode = 'n' },
    }

    -- Support which-key v3 (add) and v2 (register)
    if wk.add then
      wk.add(groups)
    else
      -- Fallback for older which-key API
      wk.register({
        e = { name = 'Explorer' },
        f = { name = 'Find' },
        t = { name = 'Terminal/Tab' },
        l = { name = 'REPL' },
        w = { name = 'Workspace' },
        s = { name = 'Splits' },
        o = { name = 'Outline' },
        b = { name = 'Brain/Notes' },
        p = { name = 'Pomodoro' },
        d = { name = 'Definitions' },
        j = { name = 'Jira' },
      }, { mode = { 'n', 'v' }, prefix = '<leader>' })

      wk.register({ name = 'LSP/Go' }, { mode = 'n', prefix = 'g' })
    end
  end,
}
