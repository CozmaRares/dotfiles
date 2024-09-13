local awful = require "awful"
local bling = require "modules.bling"
local beautiful = require "beautiful"

math.randomseed(os.time())

awful.screen.connect_for_each_screen(function(s)
  awful.tag(beautiful.tags, s, awful.layout.layouts[1])

  require "topbar"(s)

  bling.module.wallpaper.setup {
    set_function = bling.module.wallpaper.setters.random,
    wallpaper = os.getenv "HOME" .. "/Pictures/Wallpapers",
    change_timer = 607,
    screen = s,
    position = "maximized",
  }
end)
