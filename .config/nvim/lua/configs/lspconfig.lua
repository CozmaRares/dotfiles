local nvlsp = require "nvchad.configs.lspconfig"
nvlsp.defaults() -- also automatically loads lua_ls

local on_attach = nvlsp.on_attach
local on_init = nvlsp.on_init
local capabilities = nvlsp.capabilities
capabilities.textDocument.completion.completionItem.snippetSupport = true

local lspconfig = require "lspconfig"
local root_pattern = lspconfig.util.root_pattern

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

local callbacks = {
  on_attach = on_attach,
  on_init = on_init,
  capabilities = capabilities,
}

for _, server in ipairs(servers) do
  lspconfig[server].setup(callbacks)
end
