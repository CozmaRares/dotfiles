-- This file needs to have same structure as nvconfig.lua
-- https://github.com/NvChad/ui/blob/v3.0/lua/nvconfig.lua
-- Please read that file to know all available options :(

---@type ChadrcConfig
local M = {}

M.base46 = {
  theme = "tokyonight",
  transparency = true,

  hl_override = {
    Comment = { italic = true, fg = "#ffd700" },
    ["@comment"] = { italic = true, fg = "#ffd700" },
    NvDashAscii = {
      fg = "blue",
      bg = "none",
    },
    NvDashButtons = {
      fg = "blue",
      bg = "none",
    },
  },
}

M.nvdash = { load_on_startup = true }

M.ui = {
  telescope = {
    style = "bordered",
  },

  statusline = {
    -- default/round/block/arrow separators work only for default statusline theme
    -- round and block will work for minimal theme only
    separator_style = "block",
    order = {
      "mode",
      "file",
      "%=",
      "lsp_msg",
      "%=",
      "diagnostics",
      "lsp",
    },
  },
}

return M
