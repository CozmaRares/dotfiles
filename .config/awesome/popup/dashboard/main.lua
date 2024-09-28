local awful = require "awful"
local wibox = require "wibox"
local beautiful = require "beautiful"
local colors = beautiful.other.colors

local widget = {
  {
    text = "test",
    widget = wibox.widget.textbox,
  },
  widget = wibox.container.background,
  forced_width = awful.screen.focused().geometry.width,
  forced_height = awful.screen.focused().geometry.height - beautiful.wibar_height,
  layout = wibox.layout.grid,
  bg = colors.cyan,
}

local dashboard = awful.popup {
  widget = widget,
  ontop = true,
  visible = false,
  placement = function(popup)
    awful.placement.top_left(
      popup,
      { margins = { top = beautiful.wibar_height, left = 0 }, parent = awful.screen.focused() }
    )
  end,
}

return dashboard
