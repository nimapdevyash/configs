return {
  "3rd/image.nvim",
  config = function()
    local image = require("image")

    image.setup({
      backend = "kitty",
      kitty_method = "normal",
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
  end,
}
