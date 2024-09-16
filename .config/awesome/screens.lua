local awful = require "awful"
local bling = require "bling"
local beautiful = require "beautiful"

awful.screen.connect_for_each_screen(function(s)
  awful.tag(beautiful.tags, s, awful.layout.layouts[1])

  require "topbar.main"(s)

  bling.module.wallpaper.setup {
    set_function = bling.module.wallpaper.setters.random,
    wallpaper = os.getenv "HOME" .. "/Pictures/Wallpapers",
    change_timer = 3607,
    screen = s,
    position = "maximized",
  }
end)
