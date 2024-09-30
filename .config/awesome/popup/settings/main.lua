local awful = require "awful"
local wibox = require "wibox"
local gshape = require "gears.shape"
local beautiful = require "beautiful"
local colors = beautiful.other.colors
local spacing = beautiful.settings_spacing

local buttons = require "popup.settings.buttons"
local sliders = require "popup.settings.sliders"

local widget = wibox.widget {
  {
    {
      buttons.wifi,
      buttons.bluetooth,
      buttons.silent,
      buttons.nightmode,
      layout = wibox.layout.grid,
      forced_num_cols = 2,
      forced_num_rows = 2,
      homogeneous = true,
      expand = true,
      spacing = spacing,
    },
    widget = wibox.container.margin,
    top = spacing,
    bottom = spacing,
    right = spacing,
    left = spacing,
  },
  {
    sliders.volume,
    widget = wibox.container.margin,
    top = 0,
    bottom = spacing,
    right = spacing,
    left = spacing,
  },
  {
    sliders.brightness,
    widget = wibox.container.margin,
    top = 0,
    bottom = spacing,
    right = spacing,
    left = spacing,
  },
  layout = wibox.layout.fixed.vertical,
}

local settings = awful.popup {
  widget = widget,
  ontop = true,
  visible = false,
  placement = function(popup)
    awful.placement.top_right(popup, { margins = { top = 30, right = 10 }, parent = awful.screen.focused() })
  end,
  shape = function(cr, width, height)
    gshape.rounded_rect(cr, width, height, beautiful.settings_buttnons_radius + spacing)
  end,
  opacity = 1,
  bg = colors.bg_dark,
}

settings:connect_signal("mouse::leave", function()
  settings.hide()
end)

function settings.show()
  buttons.wifi.refresh()
  buttons.bluetooth.refresh()
  buttons.silent.refresh()
  buttons.nightmode.refresh()

  sliders.volume.update()
  sliders.brightness.update()

  settings:move_next_to(awful.screen.focused())
  settings.visible = true
end

function settings.hide()
  settings.visible = false
end

function settings.toggle()
  if not settings.visible then
    settings.show()
  else
    settings.hide()
  end
end

return settings
