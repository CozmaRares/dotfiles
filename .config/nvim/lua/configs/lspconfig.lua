require("nvchad.configs.lspconfig").defaults()

local servers = {
  "astro",
  "clangd",
  "cssls",
  "emmet_ls",
  "html",
  "rust_analyzer",
  "tailwindcss",
  "ts_ls",
}
vim.lsp.enable(servers)
