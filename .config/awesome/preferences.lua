local keys = require "keys"
local awful = require "awful"

local M = {}

M.apps = {
  terminal = "kitty",
  editor = "nvim",
  file_exp = "thunar",
  browser = "firefox",
}

M.cmds = {
  editor = M.apps.terminal .. " -e " .. M.apps.editor,
}

M.user = {
  modkey = keys.mod.win,
}

M.startup = {
  "picom",
  "redshift -P -O 3500",
  "jamesdsp --tray"
}

M.layouts = {
  awful.layout.suit.tile.left,
  awful.layout.suit.floating,
  awful.layout.suit.fair.horizontal,
  -- awful.layout.suit.tile,
  -- awful.layout.suit.tile.bottom,
  -- awful.layout.suit.tile.top,
  -- awful.layout.suit.fair,
  -- awful.layout.suit.spiral,
  -- awful.layout.suit.spiral.dwindle,
  -- awful.layout.suit.max,
  -- awful.layout.suit.max.fullscreen,
  -- awful.layout.suit.magnifier,
  -- awful.layout.suit.corner.nw,
  -- awful.layout.suit.corner.ne,
  -- awful.layout.suit.corner.sw,
  -- awful.layout.suit.corner.se,
}

return M
