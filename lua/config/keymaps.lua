-- -- Keymaps are automatically loaded on the VeryLazy event
-- -- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- -- Add any additional keymaps here

-----------------------------------------------------------------------------------------------------------------
---------------------------------                GIt BLAME TOGGLE                --------------------------------
-----------------------------------------------------------------------------------------------------------------

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
vim.keymap.set("n", "<leader>gt", toggle_blame, { desc = "Toggle Line Blame" })

-- Logpoint config
local dap = require("dap")

vim.keymap.set("n", "<leader>dL", function()
  vim.ui.input({ prompt = "Log Message: " }, function(msg)
    if msg then
      dap.set_breakpoint(nil, nil, msg)
    end
  end)
end, { desc = "Set Logpoint" })

-----------------------------------------------------------------------------------------------------------------
---------------------------------                      DAP                       --------------------------------
-----------------------------------------------------------------------------------------------------------------

local logpoints = {}

vim.keymap.set("n", "<leader>dL", function()
  local bufnr = vim.api.nvim_get_current_buf()
  local line = vim.fn.line(".")
  local key = bufnr .. ":" .. line

  if logpoints[key] then
    -- Remove logpoint
    dap.clear_breakpoints(bufnr)
    logpoints[key] = nil
    vim.notify("Logpoint removed")
    return
  end

  -- Ask for log message
  vim.ui.input({ prompt = "Logpoint message: " }, function(msg)
    if not msg or msg == "" then
      vim.notify("Cancelled")
      return
    end

    dap.set_breakpoint(nil, nil, msg)
    logpoints[key] = true
    vim.notify("Logpoint added: " .. msg)
  end)
end, { desc = "Toggle Logpoint (Add/Remove)" })
