local awful = require "awful"
local wibox = require "wibox "
local gshape = require "gears.shape"
local beautiful = require "beautiful"
local colors = beautiful.other.colors
local dpi = beautiful.xresources.apply_dpi

local settings = awful.popup {
  widget = wibox.container.background,
  ontop = true,
  bg = colors.bg_dark,
  visible = false,
  placement = function(popup)
    awful.placement.top_right(popup, { margins = { top = 30, right = 10 }, parent = awful.screen.focused() })
  end,
  shape = function(cr, width, height)
    gshape.rounded_rect(cr, width, height, 0)
  end,
  opacity = 1,
}

function settings.toggle()
  settings.visible = not settings.visible
end

settings:setup {
  {
    {
      {
        {
          wifi,
          bluetooth,
          layout = wibox.layout.fixed.horizontal,
        },
        {
          silent,
          nightmode,
          layout = wibox.layout.fixed.horizontal,
        },
        layout = wibox.layout.fixed.vertical,
      },
      widget = wibox.container.margin,
      top = dpi(11),
      bottom = dpi(11),
      right = dpi(11),
      left = dpi(11),
    },
    {
      brightness,
      widget = wibox.container.margin,
      top = 0,
      bottom = dpi(11),
      right = dpi(11),
      left = dpi(11),
    },
    {
      volume,
      widget = wibox.container.margin,
      top = 0,
      bottom = dpi(11),
      right = dpi(11),
      left = dpi(11),
    },
    layout = wibox.layout.fixed.vertical,
  },
  widget = wibox.container.background,
  bg = colors.bg_dark,
  shape = function(cr, width, height)
    gshape.rounded_rect(cr, width, height, 10)
  end,
}

return settings
