local gtable = require "gears.table"
local awful = require "awful"
local wibox = require "wibox"
local modkey = require("preferences").user.modkey
local keys = require "keys"
local beautiful = require "beautiful"
local colors = beautiful.other.colors

local awesome_logo = require "widgets.awesome_logo"
local battery = require "widgets.battery"()
local calendar = require "widgets.calendar"()
local systray = require "widgets.systray"
local separator = wibox.widget.textbox "  "

local clock = wibox.widget.textclock(
  '<span color="' .. colors.fg_normal .. '" font="' .. beautiful.other.font(12) .. '"> %a %b %d, %I:%M %p </span>'
)

clock:connect_signal("button::press", function(_, _, _, button)
  if button == keys.mouse.left then
    calendar.toggle()
  end
end)

local taglist_buttons = gtable.join(
  awful.button({}, keys.mouse.left, function(t)
    t:view_only()
  end),
  awful.button({ modkey }, keys.mouse.left, function(t)
    if client.focus then
      client.focus:move_to_tag(t)
    end
  end),
  awful.button({}, keys.mouse.wheel, awful.tag.viewtoggle),
  awful.button({ modkey }, keys.mouse.wheel, function(t)
    if client.focus then
      client.focus:toggle_tag(t)
    end
  end),
  awful.button({}, keys.mouse.scroll_up, function(t)
    awful.tag.viewnext(t.screen)
  end),
  awful.button({}, keys.mouse.scroll_down, function(t)
    awful.tag.viewprev(t.screen)
  end)
)

awful.screen.connect_for_each_screen(function(s)
  awful.tag({ "1", "2", "3", "4", "5", "6", "7", "8", "9" }, s, awful.layout.layouts[1])

  s.mylayoutbox = awful.widget.layoutbox(s)
  s.mylayoutbox:buttons(gtable.join(
    awful.button({}, 1, function()
      awful.layout.inc(1)
    end),
    awful.button({}, 3, function()
      awful.layout.inc(-1)
    end),
    awful.button({}, 4, function()
      awful.layout.inc(1)
    end),
    awful.button({}, 5, function()
      awful.layout.inc(-1)
    end)
  ))

  s.mytaglist = awful.widget.taglist {
    screen = s,
    filter = awful.widget.taglist.filter.all,
    buttons = taglist_buttons,
  }

  s.wibox = awful.wibar { position = "top", screen = s }

  s.wibox:setup {
    layout = wibox.layout.align.horizontal,
    {
      layout = wibox.layout.fixed.horizontal,
      awesome_logo,
      separator,
      s.mytaglist,
    },
    nil,
    {
      layout = wibox.layout.fixed.horizontal,
      systray,
      {
        clock,
        valign = "center",
        halign = "center",
        layout = wibox.container.place,
      },
      separator,
      battery,
      separator,
      s.mylayoutbox,
      separator,
    },
  }
end)
