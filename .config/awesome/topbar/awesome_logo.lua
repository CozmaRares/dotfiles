--Standard Modules
local gears = require "gears"
local wibox = require "wibox"
local beautiful = require "beautiful"
local dpi = beautiful.xresources.apply_dpi
local dashboard = require "popup.dashboard.main"

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
  dashboard.visible = not dashboard.visible
end)

return widget
