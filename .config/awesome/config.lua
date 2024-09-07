local keys = require "keys"

local M = {}

M.apps = {
  terminal = "kitty",
  editor = "nvim",
  file_exp = "thunar",
}

M.cmds = {
  editor = M.apps.terminal .. " -e " .. M.apps.editor,
}

M.user = {
  modkey = keys.mod.win,
}

M.startup = {
  "picom",
  "nitrogen --random --set-zoom-fill ~/Pictures/Wallpapers",
  "redshift -P -O 3500",
  -- "jamesdsp"
}

return M
