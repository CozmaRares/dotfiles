local options = {
  formatters_by_ft = {
    lua = { "stylua" },

    css = { "prettierd" },
    html = { "prettierd" },
    javascript = { "prettierd" },
    javascriptreact = { "prettierd" },
    typescript = { "prettierd" },
    typescriptreact = { "prettierd" },
    svelte = { "prettierd" },

    markdown = { "markdownlint" },

    ["_"] = { "trim_whitespace" },
  },
}

require("conform").setup(options)
