-------------------------------------------------
-- Calendar Widget for Awesome Window Manager
-- Shows the current month and supports scroll up/down to switch month
-- More details could be found here:
-- https://github.com/streetturtle/awesome-wm-widgets/tree/master/calendar-widget

-- @author Pavel Makhov
-- @copyright 2019 Pavel Makhov
-------------------------------------------------

local awful = require "awful"
local wibox = require "wibox"
local gears = require "gears"
local colors = require("beautiful").other.colors
local keys = require "keys"

local calendar_widget = {}

return function()
  local calendar_theme = {
    bg = colors.bg_dark,
    fg = colors.fg_normal,
    focus_date_bg = colors.blue,
    focus_date_fg = colors.bg_dark,
    weekend_day_bg = colors.bg_normal,
    weekday_fg = colors.lightblue,
    header_fg = colors.blue,
    border = colors.bg_dark,
  }

  local placement = "top_right"
  local radius = 8
  local start_sunday = false

  local styles = {}
  local function rounded_shape(size)
    return function(cr, width, height)
      gears.shape.rounded_rect(cr, width, height, size)
    end
  end

  styles.month = {
    padding = 4,
    bg_color = calendar_theme.bg,
    border_width = 0,
  }

  styles.normal = {
    markup = function(t)
      return t
    end,
    shape = rounded_shape(4),
  }

  styles.focus = {
    fg_color = calendar_theme.focus_date_fg,
    bg_color = calendar_theme.focus_date_bg,
    markup = function(t)
      return "<b>" .. t .. "</b>"
    end,
    shape = rounded_shape(4),
  }

  styles.header = {
    fg_color = calendar_theme.header_fg,
    bg_color = calendar_theme.bg,
    markup = function(t)
      return "<b>" .. t .. "</b>"
    end,
  }

  styles.weekday = {
    fg_color = calendar_theme.weekday_fg,
    bg_color = calendar_theme.bg,
    markup = function(t)
      return t
    end,
  }

  local function decorate_cell(widget, flag, date)
    if flag == "monthheader" and not styles.monthheader then
      flag = "header"
    end

    -- highlight only today's day
    if flag == "focus" then
      local today = os.date "*t"
      if not (today.month == date.month and today.year == date.year) then
        flag = "normal"
      end
    end

    local props = styles[flag] or {}
    if props.markup and widget.get_text and widget.set_markup then
      widget:set_markup(props.markup(widget:get_text()))
    end
    -- Change bg color for weekends
    local d = { year = date.year, month = (date.month or 1), day = (date.day or 1) }
    local weekday = tonumber(os.date("%w", os.time(d)))
    local default_bg = (weekday == 0 or weekday == 6) and calendar_theme.weekend_day_bg or calendar_theme.bg
    local ret = wibox.widget {
      {
        {
          widget,
          halign = "center",
          widget = wibox.container.place,
        },
        margins = (props.padding or 2) + (props.border_width or 0),
        widget = wibox.container.margin,
      },
      shape = props.shape,
      shape_border_color = props.border_color or "#000000",
      shape_border_width = props.border_width or 0,
      fg = props.fg_color or calendar_theme.fg,
      bg = props.bg_color or default_bg,
      widget = wibox.container.background,
    }

    return ret
  end

  local cal = wibox.widget {
    date = os.date "*t",
    font = "JetBrainsMono NF 14",
    fn_embed = decorate_cell,
    long_weekdays = true,
    start_sunday = start_sunday,
    widget = wibox.widget.calendar.month,
  }

  local popup = awful.popup {
    ontop = true,
    visible = false,
    shape = rounded_shape(radius),
    offset = { y = 15 },
    border_width = 9,
    border_color = calendar_theme.border,
    widget = cal,
  }

  local next_month = function()
    local a = cal:get_date()
    a.month = a.month + 1
    cal:set_date(nil)
    cal:set_date(a)
    popup:set_widget(cal)
  end

  local prev_month = function()
    local a = cal:get_date()
    a.month = a.month - 1
    cal:set_date(nil)
    cal:set_date(a)
    popup:set_widget(cal)
  end

  popup:buttons(
    awful.util.table.join(
      awful.button({}, keys.mouse.left, next_month),
      awful.button({}, keys.mouse.scroll_up, next_month),
      awful.button({}, keys.mouse.right, prev_month),
      awful.button({}, keys.mouse.scroll_down, prev_month)
    )
  )

  popup:connect_signal("mouse::leave", function()
    calendar_widget.toggle()
  end)

  function calendar_widget.toggle()
    if popup.visible then
      cal:set_date(nil)
      cal:set_date(os.date "*t")
      popup:set_widget(nil)
      popup:set_widget(cal)
      popup.visible = not popup.visible
    else
      if placement == "top" then
        awful.placement.top(popup, { margins = { top = 50 }, parent = awful.screen.focused() })
      elseif placement == "top_right" then
        awful.placement.top_right(popup, { margins = { top = 30, right = 10 }, parent = awful.screen.focused() })
      elseif placement == "top_left" then
        awful.placement.top_left(popup, { margins = { top = 30, left = 10 }, parent = awful.screen.focused() })
      elseif placement == "bottom_right" then
        awful.placement.bottom_right(popup, {
          margins = { bottom = 30, right = 10 },
          parent = awful.screen.focused(),
        })
      elseif placement == "bottom_left" then
        awful.placement.bottom_left(popup, {
          margins = { bottom = 30, left = 10 },
          parent = awful.screen.focused(),
        })
      else
        awful.placement.top(popup, { margins = { top = 45 }, parent = awful.screen.focused() })
      end

      popup.visible = true
    end
  end

  return calendar_widget
end
