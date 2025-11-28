-----------------------------------------------------------------------------------------------------------------
---------------------------------                 DEPENDENCIES                  ---------------------------------
-----------------------------------------------------------------------------------------------------------------

-- Safely load Gitsigns
local ok_g, gitsigns = pcall(require, "gitsigns")
if not ok_g then
  vim.notify("Gitsigns not found", vim.log.levels.WARN)
  return
end

-- Safely load DAP
local ok_dap, dap = pcall(require, "dap")
if not ok_dap then
  vim.notify("DAP not found", vim.log.levels.WARN)
  return
end

-- Load Snacks for toggle support
local Snacks = require("snacks")

-----------------------------------------------------------------------------------------------------------------
---------------------------------             GITSIGNS BLAME TOGGLE             ---------------------------------
-----------------------------------------------------------------------------------------------------------------

-- Track blame state manually
local blame_enabled = false

Snacks.toggle
  .option("git_blame", {
    name = "Git Blame (current line)",
    get = function()
      return blame_enabled
    end,
    set = function(val)
      gitsigns.toggle_current_line_blame()
      blame_enabled = val
      vim.notify("Git Blame: " .. (val and "ON" or "OFF"))
    end,
  })
  :map("<leader>gt")

-----------------------------------------------------------------------------------------------------------------
---------------------------------              DAP LOGPOINT TOGGLE              ---------------------------------
-----------------------------------------------------------------------------------------------------------------

-- Track logpoints per buffer and line
local logpoints = {}

Snacks.toggle
  .option("dap_logpoint", {
    name = "Logpoint",
    get = function()
      local bufnr = vim.api.nvim_get_current_buf()
      local line = vim.fn.line(".")
      return logpoints[bufnr .. ":" .. line] == true
    end,
    set = function(val)
      local bufnr = vim.api.nvim_get_current_buf()
      local line = vim.fn.line(".")
      local key = bufnr .. ":" .. line

      if not val then
        dap.clear_breakpoints(bufnr)
        logpoints[key] = nil
        vim.notify("Logpoint removed")
        return
      end

      vim.ui.input({ prompt = "Logpoint message: " }, function(msg)
        if not msg or msg == "" then
          vim.notify("Cancelled")
          return
        end

        dap.set_breakpoint(nil, nil, msg)
        logpoints[key] = true
        vim.notify("Logpoint added: " .. msg)
      end)
    end,
  })
  :map("<leader>dL")

-----------------------------------------------------------------------------------------------------------------
---------------------------------              ADDITIONAL KEYMAPS               ---------------------------------
-----------------------------------------------------------------------------------------------------------------

-- Add more custom keymaps below this line
-- Example:
-- vim.keymap.set("n", "<leader>xx", "<cmd>SomeCommand<cr>", { desc = "Description" })
