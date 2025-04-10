return {
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
}
