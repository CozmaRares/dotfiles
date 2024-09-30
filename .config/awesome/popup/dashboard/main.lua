local awful = require "awful"
local wibox = require "wibox"
local beautiful = require "beautiful"
local colors = beautiful.other.colors

local widget = {
  {
    text = "test",
    widget = wibox.widget.textbox,
    forced_width = awful.screen.focused().geometry.width,
    forced_height = awful.screen.focused().geometry.height - beautiful.wibar_height,
  },
  layout = wibox.layout.grid,
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
  bg = colors.bg_dark .. "70",
}

dashboard.toggle = function()
  -- dashboard:move_next_to(awful.screen.focused())
  dashboard.visible = not dashboard.visible
end

return dashboard
