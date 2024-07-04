return {
  {
    "stevearc/conform.nvim",
    config = function()
      require "configs.conform"
    end,
  },
  {
    "neovim/nvim-lspconfig",
    config = function()
      require("nvchad.configs.lspconfig").defaults()
      require "configs.lspconfig"
    end,
  },
  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        "clangd",
        "cpplint",
        "css-lsp",
        "emmet-ls",
        "eslint_d",
        "html-lsp",
        "intelephense",
        "lua-language-server",
        "markdownlint",
        "prettierd",
        "rust-analyzer",
        "stylua",
        "tailwindcss-language-server",
        "typescript-language-server",
      },
    },
  },
  {
    "mfussenegger/nvim-lint",
    lazy = false,
    config = function()
      require "configs.lint"
    end,
  },
}
