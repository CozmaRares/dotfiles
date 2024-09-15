local awful = require "awful"
local gears = require "gears"
local beautiful = require "beautiful"
local wibox = require "wibox"
local dpi = beautiful.xresources.apply_dpi
local keys = require "keys"
local cmds = require("preferences").cmds

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
power:connect_signal("button::release", function(_, _, _, button)
  if button == keys.mouse.left then
    awful.spawn(cmds.launcher.powermenu)
  end
end)

local wifi = create_button "wifi"
wifi:connect_signal("button::release", function()
  awful.spawn.with_shell(cmds.launcher.wifi)
end)

local blth = create_button "bluetooth"
blth:connect_signal("button::release", function()
  awful.spawn.with_shell(cmds.launcher.bluetooth)
end)

local volume = create_button "speaker"
-- music:connect_signal("button::release", function()
--   media.visible = not media.visible
--   control.visible = false
-- end)

local brightness = create_button "bulb"
-- music:connect_signal("button::release", function()
--   media.visible = not media.visible
--   control.visible = false
-- end)

local nightlight = create_button "lamp"
-- music:connect_signal("button::release", function()
--   media.visible = not media.visible
--   control.visible = false
-- end)

--Main Window
local grouped_buttons = wibox.widget {
  {
    separator,
    nightlight,
    separator,
    brightness,
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
