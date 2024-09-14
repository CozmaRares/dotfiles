local beautiful = require "beautiful"
local colors = beautiful.other.colors
local wibox = require "wibox"
local keys = require "keys"

local calendar = require "topbar.popup.calendar"()

local clock = wibox.widget.textclock(
  '<span color="' .. colors.fg_normal .. '" font="' .. beautiful.other.font(12) .. '"> %a %b %d, %I:%M %p </span>'
)

clock:connect_signal("button::press", function(_, _, _, button)
  if button == keys.mouse.left then
    calendar.toggle()
  end
end)

return clock
