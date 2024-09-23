--Standard Modules
local awful = require "awful"
local gears = require "gears"
local wibox = require "wibox"
local beautiful = require "beautiful"
local dpi = beautiful.xresources.apply_dpi

-- topbar icons path
local tip = os.getenv "HOME" .. "/.config/awesome/icons/topbar/"
local open_icon = tip .. "arrow_left.svg"
local close_icon = tip .. "arrow_right.svg"

local base_systray = wibox.widget.systray()
local systray = wibox.widget {
  base_systray,
  widget = wibox.container.margin,
  left = dpi(2),
  right = dpi(2),
  visible = false,
}

local arrow = wibox.widget {
  id = "icon",
  widget = wibox.widget.imagebox,
  image = open_icon,
  resize = true,
  opacity = 1,
}

local tray_toggle = wibox.widget {
  {
    arrow,
    left = dpi(3),
    right = 0,
    top = dpi(3),
    bottom = dpi(3),
    widget = wibox.container.margin,
  },
  shape = gears.shape.rounded_rect,
  widget = wibox.container.background,
}

local widget = wibox.widget {
  {
    {
      systray,
      tray_toggle,
      layout = wibox.layout.fixed.horizontal,
    },
    widget = wibox.container.background,
    shape = gears.shape.rounded_rect,
  },
  left = dpi(3),
  right = dpi(0),
  top = dpi(3),
  bottom = dpi(3),
  widget = wibox.container.margin,
}

--Toggle function for systray
tray_toggle:connect_signal("button::press", function(_, _, _, button)
  if button == 1 then
    systray.visible = not systray.visible
    if systray.visible then
      base_systray:set_screen(awful.screen.focused())
      arrow:set_image(close_icon)
    else
      arrow:set_image(open_icon)
    end
  end
end)

return widget
