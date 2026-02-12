
return {
  {
    "neovim/nvim-lspconfig",
    opts = function(_, opts)
      opts.servers = opts.servers or {}

      -- keep config but prevent auto setup
      opts.servers.typos_lsp = {
        autostart = false,
      }

      -- THIS disables LazyVim auto-initializing it
      opts.setup = opts.setup or {}
      opts.setup.typos_lsp = function()
        return true
      end
    end,
  },
}

