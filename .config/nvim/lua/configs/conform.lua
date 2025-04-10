local options = {
  formatters_by_ft = {
    lua = { "stylua" },
    bash = { "beautysh" },

    css = { "prettierd" },
    html = { "prettierd" },
    javascript = { "prettierd" },
    javascriptreact = { "prettierd" },
    json = { "prettierd" },
    markdown = { "prettierd" },
    svelte = { "prettierd" },
    typescript = { "prettierd" },
    typescriptreact = { "prettierd" },
  },

  -- format_on_save = {
  --   -- These options will be passed to conform.format()
  --   timeout_ms = 500,
  --   lsp_fallback = true,
  -- },
}

return options
