local gears = require "gears"
local beautiful = require "beautiful"

beautiful.init(gears.filesystem.get_themes_dir() .. "default/theme.lua")

beautiful.useless_gap = 8
