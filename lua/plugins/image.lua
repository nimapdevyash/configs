-- return {
--   "3rd/image.nvim",
--   config = function()
--     local image = require("image")
--
--     image.setup({
--       backend = "kitty",
--       kitty_method = "normal",
--       integrations = {
--         markdown = {
--           enabled = true,
--           sizing_strategy = "auto",
--           download_remote_images = false,
--           clear_in_insert_mode = false,
--         },
--         neorg = { enabled = false },
--       },
--     })
--   end,
-- }

return {
  -- Inline image rendering
  {
    "3rd/image.nvim",
    config = function()
      local image = require("image")

      image.setup({
        backend = "kitty", -- or wezterm / ueberzug
        kitty_method = "normal", -- required
        integrations = {
          markdown = {
            enabled = true,
            sizing_strategy = "auto",
            download_remote_images = false,
            clear_in_insert_mode = false,
          },
          neorg = { enabled = false },
        },
      })

      -- Keymaps for inline preview (no zoom capabilities)
      vim.keymap.set("n", "<leader>ip", function()
        print("Inline images enabled (image.nvim)")
      end, { desc = "Image preview active" })
    end,
  },

  -- feh integration (for zooming)
  {
    "nvim-lua/plenary.nvim", -- dummy dependency so Lazy can load config
    config = function()
      local map = vim.keymap.set

      -- Open current image with feh
      map("n", "<leader>iz", function()
        local file = vim.fn.expand("%:p")
        if file == "" then
          print("No file opened")
          return
        end
        vim.fn.jobstart({ "feh", file }, { detach = true })
      end, { desc = "Zoom Image using feh", silent = true })

      -- Open all images in folder (gallery mode)
      map("n", "<leader>ig", function()
        local dir = vim.fn.expand("%:p:h")
        vim.fn.jobstart({ "feh", dir }, { detach = true })
      end, { desc = "Open folder gallery (feh)", silent = true })
    end,
  },
}
