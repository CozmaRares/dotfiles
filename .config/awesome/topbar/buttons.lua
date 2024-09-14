local awful = require "awful"
local gears = require "gears"
local beautiful = require "beautiful"
local wibox = require "wibox"
local dpi = beautiful.xresources.apply_dpi
local keys = require "keys"

local separator = wibox.widget.textbox " "

local create_button = function(icon)
  return wibox.widget {
    {
      widget = wibox.widget.imagebox,
      image = os.getenv "HOME" .. "/.config/awesome/icons/topbar/" .. icon .. ".svg",
      resize = true,
    },
    left = dpi(5),
    right = dpi(5),
    top = dpi(5),
    bottom = dpi(5),
    widget = wibox.container.margin,
  }
end

local power = create_button "power"
power:connect_signal("button::press", function(_, _, _, button)
  if button == keys.mouse.left then
    awful.spawn "rofi -show powermenu -modi powermenu:~/.config/scripts/rofi-power-menu"
  end
end)

local wifi = create_button "wifi"
wifi:connect_signal("button::release", function()
  awful.spawn.with_shell(os.getenv "HOME" .. "/.config/scripts/rofi-wifi-menu.sh")
end)

local blth = create_button "bluetooth"
blth:connect_signal("button::release", function()
  awful.spawn.with_shell(os.getenv "HOME" .. "/.config/scripts/rofi-bluetooth")
end)

local volume = create_button "speaker"
-- music:connect_signal("button::release", function()
--   media.visible = not media.visible
--   control.visible = false
-- end)

--Main Window
local grouped_buttons = wibox.widget {
  {
    separator,
    volume,
    separator,
    blth,
    separator,
    wifi,
    separator,
    power,
    separator,
    layout = wibox.layout.fixed.horizontal,
  },
  widget = wibox.container.background,
  shape = gears.shape.rounded_rect,
  bg = beautiful.taglist_bg_occupied,
}

return grouped_buttons
