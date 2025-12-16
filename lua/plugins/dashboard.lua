-- Dashboard (Snacks) – LazyVim compatible
return {
  "folke/snacks.nvim",
  priority = 1000,
  lazy = false,

  ---@type snacks.Config
  opts = {
    dashboard = {
      enabled = true,

      width = 60, -- adjust so logo, onefetch, and keys align
      row = nil,
      col = nil,
      pane_gap = 4,
      autokeys = "1234567890abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ",

      preset = {
        pick = nil,

        keys = {
          { icon = " ", key = "f", desc = "Find File", action = ":lua Snacks.dashboard.pick('files')" },
          { icon = " ", key = "n", desc = "New File", action = ":ene | startinsert" },
          { icon = " ", key = "g", desc = "Find Text", action = ":lua Snacks.dashboard.pick('live_grep')" },
          { icon = " ", key = "r", desc = "Recent Files", action = ":lua Snacks.dashboard.pick('oldfiles')" },
          {
            icon = " ",
            key = "c",
            desc = "Config",
            action = ":lua Snacks.dashboard.pick('files', { cwd = vim.fn.stdpath('config') })",
          },
          { icon = " ", key = "s", desc = "Restore Session", section = "session" },
          { icon = "󰒲 ", key = "l", desc = "Lazy", action = ":Lazy", enabled = package.loaded.lazy ~= nil },
          { icon = " ", key = "q", desc = "Quit", action = ":qa" },
        },

        header = [[
.----------------.  .----------------.  .----------------.  .----------------.
| .--------------. || .--------------. || .--------------. || .--------------. |
| |  ____  ____  | || |      __      | || |    _______   | || |  ____  ____  | |
| | |_  _||_  _| | || |     /  \     | || |   /  ___  |  | || | |_   ||   _| | |
| |   \ \  / /   | || |    / /\ \    | || |  |  (__ \_|  | || |   | |__| |   | |
| |    \ \/ /    | || |   / ____ \   | || |   '.___`-.   | || |   |  __  |   | |
| |    _|  |_    | || | _/ /    \ \_ | || |  |`\____) |  | || |  _| |  | |_  | |
| |   |______|   | || ||____|  |____|| || |  |_______.'  | || | |____||____| | |
| |              | || |              | || |              | || |              | |
| '--------------' || '--------------' || '--------------' || '--------------' |
'----------------'  '----------------'  '----------------'  '----------------'
]],
      },

      formats = {
        icon = function(item)
          if item.file and (item.icon == "file" or item.icon == "directory") then
            return Snacks.dashboard.icon(item.file, item.icon)
          end
          return { item.icon, width = 2, hl = "icon" }
        end,
        header = { "%s", align = "center" },
        footer = { "%s", align = "center" },
      },

      sections = {
        { section = "header" },
        { section = "keys", gap = 1, padding = 1 },
        { section = "startup" },
      },
    },
  },
}
