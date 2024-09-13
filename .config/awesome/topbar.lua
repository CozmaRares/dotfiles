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
local fancy_taglist = require "fancy_taglist"

local separator1 = wibox.widget.textbox " "
local separator2 = wibox.widget.textbox "  "

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

local tasklist_buttons = gtable.join(
  awful.button({}, 1, function(c)
    if c == client.focus then
      c.minimized = true
    else
      c:emit_signal("request::activate", "tasklist", { raise = true })
    end
  end),
  awful.button({}, 3, function()
    awful.menu.client_list { theme = { width = 250 } }
  end),
  awful.button({}, 4, function()
    awful.client.focus.byidx(1)
  end),
  awful.button({}, 5, function()
    awful.client.focus.byidx(-1)
  end)
)

return function(s)
  s.layoutbox = awful.widget.layoutbox(s)
  s.layoutbox:buttons(gtable.join(
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

  s.taglist = fancy_taglist.new {
    screen = s,
    taglist = { buttons = taglist_buttons },
    tasklist = { buttons = tasklist_buttons },
  }

  s.wibox = awful.wibar { position = beautiful.wibar_position, screen = s }

  s.wibox:setup {
    {
      separator1,
      awesome_logo,
      separator2,
      s.taglist,
      layout = wibox.layout.fixed.horizontal,
    },
    nil,
    {
      systray,
      separator1,
      {
        clock,
        valign = "center",
        halign = "center",
        layout = wibox.container.place,
      },
      separator2,
      battery,
      separator2,
      s.layoutbox,
      separator1,
      layout = wibox.layout.fixed.horizontal,
    },
    layout = wibox.layout.align.horizontal,
  }
end
