local gears = require "gears"
local awful = require "awful"
local wibox = require "wibox"
local beautiful = require "beautiful"
local dpi = beautiful.xresources.apply_dpi
local colors = beautiful.other.colors
local calendar_widget = require "widgets.calendar"
local fancy_taglist = require "fancy_taglist"
local modkey = require("preferences").user.modkey
local batteryarc_widget = require "widgets.battery"

-- WIDGETS =============

local battery = batteryarc_widget()
local calendar = calendar_widget()

local clock = wibox.widget.textclock(
  '<span color="' .. colors.fg_normal .. '" font="JetBrainsMono NF 12"> %a %b %d, %I:%M %p </span>',
  10
)

clock:connect_signal("button::press", function(_, _, _, button)
  if button == 1 then
    calendar.toggle()
  end
end)

local separator = wibox.widget.textbox "     "

-- WIDGETS =============

local taglist_buttons = gears.table.join(
  awful.button({}, 1, function(t)
    t:view_only()
  end),
  awful.button({ modkey }, 1, function(t)
    if client.focus then
      client.focus:move_to_tag(t)
    end
  end),
  awful.button({}, 3, awful.tag.viewtoggle),
  awful.button({ modkey }, 3, function(t)
    if client.focus then
      client.focus:toggle_tag(t)
    end
  end),
  awful.button({}, 4, function(t)
    awful.tag.viewnext(t.screen)
  end),
  awful.button({}, 5, function(t)
    awful.tag.viewprev(t.screen)
  end)
)

local tasklist_buttons = gears.table.join(
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

awful.screen.connect_for_each_screen(function(s)
  local taglist = fancy_taglist.new {
    screen = s,
    taglist = { buttons = taglist_buttons },
    tasklist = { buttons = tasklist_buttons },
    filter = awful.widget.taglist.filter.all,
    style = {
      shape = gears.shape.rounded_rect,
    },
  }

  s.taglist = wibox.widget {
    {
      taglist,
      widget = wibox.container.background,
      shape = gears.shape.rounded_rect,
      bg = colors.bg_normal,
    },
    left = dpi(3),
    right = dpi(3),
    top = dpi(3),
    bottom = dpi(3),
    widget = wibox.container.margin,
  }

  local awesome_logo = require "widgets.awesome_logo"

  s.wibox = awful.wibar {
    position = "top",
    -- margins = { top = dpi(7), left = dpi(8), right = dpi(8), bottom = 0 },
    margins = { top = dpi(0), left = dpi(0), right = dpi(0), bottom = 0 },
    screen = s,
    height = dpi(35),
    opacity = 1,
    fg = colors.lightblue,
    bg = "#00000000",
    -- shape = function(cr, width, height)
    --   -- gears.shape.rounded_rect(cr, width, height, 8)
    --   gears.shape.rounded_rect(cr, width, height, 0)
    -- end,
  }

  --Main Wibar
  s.wibox:setup {
    layout = wibox.layout.stack,
    {
      layout = wibox.layout.stack,
      expand = "none",
      {
        layout = wibox.layout.align.horizontal,
        {
          -- Left widgets
          layout = wibox.layout.fixed.horizontal,
          separator,
          awesome_logo,
          separator,
          fancy_taglist,
          separator,
        },
        nil,
        {
          -- Right widgets
          layout = wibox.layout.fixed.horizontal,
          separator,
          battery,
          separator,
        },
      },
      {
        clock,
        valign = "center",
        halign = "center",
        layout = wibox.container.place,
      },
    },
    widget = wibox.container.background,
    bg = colors.bg_dark,
    shape = function(cr, width, height)
      gears.shape.rounded_rect(cr, width, height, 0)
      -- gears.shape.rounded_rect(cr, width, height, 0)
    end,
  }
end)
