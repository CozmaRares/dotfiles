return {
  {
    "stevearc/conform.nvim",
    opts = require "configs.conform",
  },
  {
    "neovim/nvim-lspconfig",
    config = function()
      require("nvchad.configs.lspconfig").defaults()
      require "configs.lspconfig"
    end,
  },
  {
    "supermaven-inc/supermaven-nvim",
    event = "InsertEnter",
    opts = {
      log_level = "info",
      disable_inline_completion = true,
      disable_keymaps = true,
    },
  },
}
