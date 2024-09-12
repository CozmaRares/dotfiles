local gtable = require "gears.table"
local awful = require "awful"
local wibox = require "wibox"
local batteryarc_widget = require "widgets.battery"
local calendar_widget = require "widgets.calendar"
local modkey = require("preferences").user.modkey
local keys = require "keys"
local colors = require("beautiful").other.colors

local awesome_logo = require "widgets.awesome_logo"
local battery = batteryarc_widget()
local separator = wibox.widget.textbox "  "
local calendar = calendar_widget()

local clock = wibox.widget.textclock(
  '<span color="' .. colors.fg_normal .. '" font="JetBrainsMono NF 10"> %a %b %d, %I:%M %p </span>'
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

-- local tasklist_buttons = gears.table.join(
--   awful.button({}, 1, function(c)
--     if c == client.focus then
--       c.minimized = true
--     else
--       c:emit_signal("request::activate", "tasklist", { raise = true })
--     end
--   end),
--   awful.button({}, 3, function()
--     awful.menu.client_list { theme = { width = 250 } }
--   end),
--   awful.button({}, 4, function()
--     awful.client.focus.byidx(1)
--   end),
--   awful.button({}, 5, function()
--     awful.client.focus.byidx(-1)
--   end)
-- )

awful.screen.connect_for_each_screen(function(s)
  -- Each screen has its own tag table.
  awful.tag({ "1", "2", "3", "4", "5", "6", "7", "8", "9" }, s, awful.layout.layouts[1])

  -- Create an imagebox widget which will contain an icon indicating which layout we're using.
  -- We need one layoutbox per screen.
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
  -- Create a taglist widget
  s.mytaglist = awful.widget.taglist {
    screen = s,
    filter = awful.widget.taglist.filter.all,
    buttons = taglist_buttons,
  }

  -- Create a tasklist widget
  -- s.mytasklist = awful.widget.tasklist {
  --   screen = s,
  --   filter = awful.widget.tasklist.filter.currenttags,
  --   buttons = tasklist_buttons,
  -- }

  -- Create the wibox
  s.wibox = awful.wibar { position = "top", screen = s, bg = colors.bg_dark }

  -- Add widgets to the wibox
  s.wibox:setup {
    layout = wibox.layout.align.horizontal,
    { -- Left widgets
      layout = wibox.layout.fixed.horizontal,
      awesome_logo,
      separator,
      s.mytaglist,
    },
    nil,
    { -- Right widgets
      layout = wibox.layout.fixed.horizontal,
      -- mykeyboardlayout,
      wibox.widget.systray(),
      separator,
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
