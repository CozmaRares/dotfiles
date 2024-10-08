-- This file needs to have same structure as nvconfig.lua
-- https://github.com/NvChad/ui/blob/v2.5/lua/nvconfig.lua

---@type ChadrcConfig
local M = {}

M.ui = {
  theme = "tokyonight",
  transparency = true,

  telescope = { style = "bordered" },

  nvdash = {
    load_on_startup = true,

    header = {
      "  ▄▄▄▄▄▄   ▄ ▄     █▄▄█▄▄█ ▄▄▄▄▄▄",
      "  █ ▄▄ █   ▄▄▄     █ ▄▄▄ █ █ ▄▄▄█",
      "  █▄▄█ █ ▄ █▄█ ▄▄▄ █ █▄█ █ █ █▄▄▄",
      "  ▄▄▄  █▄█▄▄▄█ █▄█▄█▄▄█▄▄█ █▄▄▄▄█",
      "  █ █▄▄█ ▄ ▄▄ ▄█ ▄▄▄▄▄▄▄▄▄▄▄▄▄▄  ",
      "  █▄▄▄▄ ▄▄▄ █ ▄ ▄▄▄ ▄ ▄▄▄ ▄ ▄ █ ▄",
      "▄ █ █▄█ █▄█ █ █ █▄█ █ █▄█ ▄▄▄ █ █",
      "█▄█ ▄ █▄▄█▄▄█ █ ▄▄█ █ ▄ █ █▄█▄█ █",
      "    █▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄█ █▄█▄▄▄█    ",
    },

    buttons = {
      { "  Find File", "Spc f f", "Telescope find_files" },
      { "󰈚  Recent Files", "Spc f o", "Telescope oldfiles" },
      { "󰈭  Find Word", "Spc f w", "Telescope live_grep" },
      { "  Bookmarks", "Spc m a", "Telescope marks" },
      { "  Themes", "Spc t h", "Telescope themes" },
      { "  Mappings", "Spc c h", "NvCheatsheet" },
    },
  },

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

  statusline = {
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
