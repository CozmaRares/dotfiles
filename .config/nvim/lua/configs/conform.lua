local options = {
  formatters_by_ft = {
    lua = { "stylua" },

    javascript = { "prettierd" },
    css = { "prettierd" },
    html = { "prettierd" },

    c = { "clang-format" },
    cpp = { "clang-format" },

    ["_"] = { "trim_whitespace" },
  },
}

require("conform").setup(options)
