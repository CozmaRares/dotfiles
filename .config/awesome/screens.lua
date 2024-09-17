local awful = require "awful"
local wallpaper = require "bling.module.wallpaper"
local beautiful = require "beautiful"

awful.screen.connect_for_each_screen(function(s)
  awful.tag(beautiful.tags, s, awful.layout.layouts[1])

  require "topbar.main"(s)

  wallpaper.setup {
    set_function = wallpaper.setters.random,
    wallpaper = os.getenv "HOME" .. "/Pictures/Wallpapers",
    change_timer = 3607,
    screen = s,
    position = "maximized",
  }
end)
