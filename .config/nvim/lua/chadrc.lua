-- This file needs to have same structure as nvconfig.lua
-- https://github.com/NvChad/ui/blob/v2.5/lua/nvconfig.lua

---@type ChadrcConfig
local M = {}

M.ui = {
  theme = "tokyonight",
  transparency = true,

  telescope = { style = "bordered" },

  hl_override = {
    Comment = { italic = true, fg = "#ffd700" },
    ["@comment"] = { italic = true, fg = "#ffd700" },
  },
}

return M
