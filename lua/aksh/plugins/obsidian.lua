local U = require('aksh.utils')

return {
  "epwalsh/obsidian.nvim",
  version = "*",
  lazy = true,
  ft = "markdown",
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
  opts = {
    workspaces = {
      {
        name = "obisidian-git",
        path = vim.env.OBSIDIAN_VAULT_PATH or vim.fn.expand("~/Documents/ObsidianVault/obsidian-git"),
      },
    },

    disable_frontmatter = true,

    note_id_func = function(title)
      -- Generate note ID with timestamp format: DD.Month.YYYY-HH.mm.ss
      local timestamp = os.date("%d.%B.%Y-%H.%M.%S")
      if title ~= nil and title ~= "" then
        return title
      else
        return timestamp
      end
    end,
    
    note_path_func = function(spec)
      -- For regular notes: use hierarchical path YYYY/MM-Month/DD/
      local year = os.date("%Y")
      local month = os.date("%m-%B")
      local day = os.date("%d")
      
      local base_path = spec.dir / "Inbox-Notes&Drafts" / "NotePadStyle"
      local full_path = base_path / year / month / day
      
      -- Create directory if it doesn't exist
      vim.fn.mkdir(tostring(full_path), "p")
      
      return full_path / (spec.id .. ".md")
    end,

    completion = {
      nvim_cmp = true,
      min_chars = 2,
    },

    templates = {
      folder = "templates",
      date_format = "%Y-%m-%d",
      time_format = "%H:%M",
    },

    mappings = {
      ["gf"] = {
        action = function()
          return require("obsidian").util.gf_passthrough()
        end,
        opts = { noremap = false, expr = true, buffer = true },
      },
      ["<leader>ch"] = {
        action = function()
          return require("obsidian").util.toggle_checkbox()
        end,
        opts = { buffer = true },
      },
    },
  },
  keys = {
    { "<leader>bn", "<cmd>ObsidianNew<cr>", desc = "New note" },
    { "<leader>bs", "<cmd>ObsidianSearch<cr>", desc = "Search notes" },
    { "<leader>bq", "<cmd>ObsidianQuickSwitch<cr>", desc = "Quick switch" },
    { "<leader>bb", "<cmd>ObsidianBacklinks<cr>", desc = "Backlinks" },
    { 
      "<leader>bt", 
      function()
        local vault_path = vim.env.OBSIDIAN_VAULT_PATH or vim.fn.expand("~/Documents/ObsidianVault/obsidian-git")
        local year = os.date("%Y")
        local month = os.date("%m-%B")
        local date = os.date("%Y-%m-%d")
        
        -- Build the path
        local folder_path = vault_path .. "/Inbox-Notes&Drafts/JournalDailyNotes/" .. year .. "/" .. month
        local file_path = folder_path .. "/" .. date .. ".md"
        
        -- Create directory if it doesn't exist
        vim.fn.mkdir(folder_path, "p")
        
        -- Open or create the file
        vim.cmd("edit " .. vim.fn.fnameescape(file_path))
        
        -- If file is new (empty), insert template from template file
        if vim.fn.line('$') == 1 and vim.fn.getline(1) == '' then
          local template_path = vault_path .. "/Templates/Daily notes template.md"
          
          -- Read template file
          local template_file = io.open(template_path, "r")
          if template_file then
            local template_content = template_file:read("*all")
            template_file:close()
            
            -- Calculate year progress
            local current_time = os.time()
            local year_num = tonumber(year)
            local start_of_year = os.time({year = year_num, month = 1, day = 1, hour = 0, min = 0, sec = 0})
            local end_of_year = os.time({year = year_num + 1, month = 1, day = 1, hour = 0, min = 0, sec = 0})
            local days_in_year = math.floor((end_of_year - start_of_year) / 86400)
            local days_passed = math.floor((current_time - start_of_year) / 86400)
            local percent_complete = math.floor((days_passed / days_in_year) * 100)
            
            -- Process Templater date syntax
            template_content = template_content:gsub('<%%[^>]*tp%.date%.now%([^)]+%)[^>]*%%>', date)
            
            -- Split into lines and add year progress after frontmatter
            local lines = {}
            local frontmatter_ended = false
            
            for line in template_content:gmatch("[^\r\n]+") do
              table.insert(lines, line)
              -- Add year progress line after the closing --- of frontmatter
              if not frontmatter_ended and line:match("^%-%-%-$") and #lines > 1 then
                frontmatter_ended = true
                table.insert(lines, "")
                table.insert(lines, string.format("**We are %d%% through %s**", percent_complete, year))
              end
            end
            
            vim.api.nvim_buf_set_lines(0, 0, -1, false, lines)
          else
            vim.notify("Template file not found: " .. template_path, vim.log.levels.WARN)
          end
        end
      end,
      desc = "Today's daily note"
    },
    { "<leader>bl", "<cmd>ObsidianFollowLink<cr>", desc = "Follow link" },
    { "<leader>bi", "<cmd>ObsidianTemplate<cr>", desc = "Insert template" },
    { "<leader>bg", "<cmd>ObsidianTags<cr>", desc = "Search tags" },
  },
}
