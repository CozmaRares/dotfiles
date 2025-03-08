local formatters_by_ft = {
  lua = { "stylua" },

  bash = { "beautysh" },
}

local ft_by_formatter = {
  prettierd = {
    "css",
    "html",
    "markdown",
    "javascript",
    "javascriptreact",
    "typescript",
    "typescriptreact",
    "svelte",
    "bash",
  },
}

for formatter, ft in pairs(ft_by_formatter) do
  formatters_by_ft[ft] = formatter
end

return {
  formatters_by_ft = formatters_by_ft,
}
