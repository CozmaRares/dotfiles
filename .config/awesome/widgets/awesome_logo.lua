--Standard Modules
local gears = require "gears"
local wibox = require "wibox"
local beautiful = require "beautiful"
local dpi = beautiful.xresources.apply_dpi

-- local dashboard = require("popups.dashboard.home.main")

--Main Logo
local widget = wibox.widget {
  {
    {
      widget = wibox.widget.imagebox,
      image = os.getenv "HOME" .. "/.config/awesome/icons/topbar/awesome-logo.jpg",
      resize = true,
      opacity = 1,
    },
    left = dpi(7),
    right = dpi(7),
    top = dpi(7),
    bottom = dpi(7),
    widget = wibox.container.margin,
  },
  shape = gears.shape.rounded_rect,
  widget = wibox.container.background,
}

-- widget:connect_signal("button::release", function()
-- 	dashboard.visible = not dashboard.visible
-- end)

return widget
