-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
-- Add any additional autocmds here
-- with vim.api.nvim_create_autocmd
--
-- Or remove existing autocmds by their group name (which is prefixed with lazyvim_ for the defaults)
-- e.g. vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")

-- Open actual image files (png/jpg/etc.) in feh instead of Neovim
vim.api.nvim_create_autocmd("BufWinEnter", {
  pattern = { ".png", ".jpg", ".jpeg", ".gif", ".bmp", ".webp" },
  callback = function()
    local file = vim.fn.expand("%:p")

    -- Fit image to window width
    vim.fn.jobstart({ "feh", "--zoom", "max", "--scale-down", file }, { detach = true })

    vim.defer_fn(function()
      if vim.bo.buftype == "" then
        vim.cmd("bd!")
      end
    end, 20)
  end,
})

-- Auto-save on buffer change, focus lost, or leaving insert mode
vim.api.nvim_create_autocmd({ "BufLeave", "FocusLost", "WinLeave", "InsertLeave" }, {
  pattern = "*",
  command = "silent! update",
})
