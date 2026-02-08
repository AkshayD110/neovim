return {
  "r7sqtr/wyw.nvim",
  cmd = { "Wyw", "WywToggle", "WywRefresh", "WywClose" },
  config = function()
    require("wyw").setup({
      sources = {
        hackernews = {
          enabled = true,
          limit = 50,
          type = "top",
        },
        zenn = {
          enabled = false,
        },
        qiita = {
          enabled = false,
        },
        developerio = {
          enabled = false,
        },
        rss = {
          feeds = {},
        },
      },
    })
  end,
  keys = {
    { "<leader>ww", "<cmd>WywToggle<cr>", desc = "Toggle News Reader" },
    { "<leader>wh", "<cmd>Wyw<cr>", desc = "Open Hacker News (Top)" },
  },
}
