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

local settings_popup = require "popup.settings.main"
local settings = create_button "settings"
settings:connect_signal("button::release", function()
  settings_popup.toggle()
end)

--Main Window
local grouped_buttons = wibox.widget {
  {
    separator,
    settings,
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
