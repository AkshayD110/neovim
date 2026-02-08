return {
  "epwalsh/pomo.nvim",
  version = "*",
  lazy = true,
  cmd = { "TimerStart", "TimerStop", "TimerRepeat", "TimerSession" },
  opts = {
    update_interval = 1000,
    
    notifiers = {
      {
        name = "Default",
        opts = {
          sticky = true,
          title_icon = "󱎫",
          text_icon = "󰄉",
        },
      },
      { name = "System" },
    },
    
    sessions = {
      pomodoro = {
        { name = "Work", duration = "25m" },
        { name = "Short Break", duration = "5m" },
        { name = "Work", duration = "25m" },
        { name = "Short Break", duration = "5m" },
        { name = "Work", duration = "25m" },
        { name = "Long Break", duration = "15m" },
      },
      deepwork = {
        { name = "Deep Work", duration = "90m" },
        { name = "Break", duration = "20m" },
      },
    },
  },
  keys = {
    { "<leader>pw", "<cmd>TimerStart 25m Work<cr>", desc = "Start 25min work timer" },
    { "<leader>pb", "<cmd>TimerStart 5m Break<cr>", desc = "Start 5min break timer" },
    { "<leader>ps", "<cmd>TimerSession pomodoro<cr>", desc = "Start pomodoro session" },
    { "<leader>pp", "<cmd>TimerPause<cr>", desc = "Pause timer" },
    { "<leader>pr", "<cmd>TimerResume<cr>", desc = "Resume timer" },
    { "<leader>px", "<cmd>TimerStop<cr>", desc = "Stop timer" },
  },
}
