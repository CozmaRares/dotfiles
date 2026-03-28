local nvlsp = require "nvchad.configs.lspconfig"
nvlsp.defaults() -- also automatically loads lua_ls

local on_attach = nvlsp.on_attach
local on_init = nvlsp.on_init
local capabilities = nvlsp.capabilities
capabilities.textDocument.completion.completionItem.snippetSupport = true

local lspconfig = require "lspconfig"
-- local root_pattern = lspconfig.util.root_pattern

local servers = {
  astro = {
    filetypes = { "astro" },
  },
  "clangd",
  "cssls",
  "emmet_ls",
  "html",
  "rust_analyzer",
  "tailwindcss",
  "ts_ls",
}

local defaults = {
  on_attach = on_attach,
  on_init = on_init,
  capabilities = capabilities,
}

for key, value in pairs(servers) do
  if type(value) == "table" then
    local config = vim.tbl_deep_extend('force', value, defaults)
    lspconfig[key].setup(config)
  else
    lspconfig[value].setup(defaults)
  end

end
