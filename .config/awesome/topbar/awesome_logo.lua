--Standard Modules
local awful = require "awful"
local wibox = require "wibox"
local beautiful = require "beautiful"
local dpi = beautiful.xresources.apply_dpi
local cmds = require("preferences").cmds

local margin = dpi(5)

--Main Logo
local widget = wibox.widget {
  {
    widget = wibox.widget.imagebox,
    image = os.getenv "HOME" .. "/.config/awesome/icons/topbar/awesome-logo.jpg",
    resize = true,
    opacity = 1,
  },
  left = margin,
  right = margin,
  top = margin,
  bottom = margin,
  widget = wibox.container.margin,
}

widget:connect_signal("button::release", function()
  awful.spawn(cmds.launcher.apps)
end)

return widget
