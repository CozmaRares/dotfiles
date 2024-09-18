local awful = require "awful"
local wibox = require "wibox"
local gshape = require "gears.shape"
local beautiful = require "beautiful"
local colors = beautiful.other.colors
local buttons = require "popup.settings.buttons"

local spacing = beautiful.settings_spacing

local settings = awful.popup {
  widget = {
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
    -- {
    --   brightness,
    --   widget = wibox.container.margin,
    --   top = 0,
    --   bottom = dpi(11),
    --   right = dpi(11),
    --   left = dpi(11),
    -- },
    -- {
    --   volume,
    --   widget = wibox.container.margin,
    --   top = 0,
    --   bottom = dpi(11),
    --   right = dpi(11),
    --   left = dpi(11),
    -- },
    layout = wibox.layout.fixed.horizontal,
    widget = wibox.container.background,
    bg = colors.bg_dark,
  },
  ontop = true,
  visible = false,
  placement = function(popup)
    awful.placement.top_right(popup, { margins = { top = 30, right = 10 }, parent = awful.screen.focused() })
  end,
  shape = function(cr, width, height)
    gshape.rounded_rect(cr, width, height, 20 + spacing)
  end,
  opacity = 1,
}

settings:connect_signal("mouse::leave", function()
  settings.hide()
end)

function settings.show()
  buttons.wifi.refresh()
  buttons.bluetooth.refresh()
  buttons.silent.refresh()
  buttons.nightmode.refresh()

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
