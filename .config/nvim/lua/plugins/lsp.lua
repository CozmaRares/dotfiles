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
  {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    opts = function()
      local opts = require "nvchad.configs.cmp"
      table.insert(opts.sources, { name = "supermaven" })
      return opts
    end,
    config = function(_, opts)
      require("cmp").setup(opts)
    end,
  },
}
