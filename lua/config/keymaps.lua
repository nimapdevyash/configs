-- -- Keymaps are automatically loaded on the VeryLazy event
-- -- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- -- Add any additional keymaps here
--
-- -- Safe import
local ok, gitsigns = pcall(require, "gitsigns")
if not ok then
  return
end

-- Track blame state
local blame_enabled = false

-- Toggle blame with notification
local function toggle_blame()
  gitsigns.toggle_current_line_blame()
  blame_enabled = not blame_enabled
  vim.notify("Gitsigns Line Blame: " .. (blame_enabled and "ON" or "OFF"))
end

-- Keymaps
vim.keymap.set("n", "<leader>gt", toggle_blame, { desc = "Toggle Git Line Blame" })

-- Logpoint config
local dap = require("dap")

vim.keymap.set("n", "<leader>dL", function()
  vim.ui.input({ prompt = "Log Message: " }, function(msg)
    if msg then
      dap.set_breakpoint(nil, nil, msg)
    end
  end)
end, { desc = "Set Logpoint" })
