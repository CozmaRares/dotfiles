local options = {
  formatters_by_ft = {
    lua = { "stylua" },

    javascript = { "prettierd" },
    css = { "prettierd" },
    html = { "prettierd" },

    markdown = { "markdownlint" },

    ["_"] = { "trim_whitespace" },
  },
}

require("conform").setup(options)
