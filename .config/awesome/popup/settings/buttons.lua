local awful = require "awful"
local wibox = require "wibox"
local gears = require "gears"
local beautiful = require "beautiful"
local dpi = beautiful.xresources.apply_dpi
local colors = beautiful.other.colors
local font = beautiful.other.font

local function create_button(container_widget, text, on_status, command1, command2)
  local function on_off(status)
    if status == true then
      return "On"
    else
      return "Off"
    end
  end

  local text_status = wibox.widget {
    markup = string.format('<span color="%s" font="%s">%s</span>', colors.white, font(11), on_off(on_status)),
    widget = wibox.widget.textbox,
  }

  local text_button = wibox.widget {
    {
      {
        markup = string.format('<span color="%s" font="%s">%s</span>', colors.lightblue, font "Bold 14", text),
        widget = wibox.widget.textbox,
      },
      text_status,
      layout = wibox.layout.fixed.vertical,
      id = "wifi",
    },
    widget = wibox.container.margin,
    top = dpi(8),
    bottom = dpi(8),
    right = dpi(8),
    left = dpi(8),
    forced_height = dpi(56),
  }

  local button_container = wibox.widget {
    container_widget,
    widget = wibox.container.margin,
    top = 3,
    bottom = 3,
    right = 10,
    left = 7,
    forced_height = dpi(56),
  }

  --Functionality
  button_container:connect_signal("button::press", function()
    on_status = not on_status
    if on_status then
      container_widget:set_bg(colors.cyan)
      awful.spawn(command1)
    else
      container_widget:set_bg(colors.grey)
      awful.spawn(command2)
      text_status:set_markup_silently(
        '<span color="' .. color.white .. '" font="Ubuntu Nerd Font 11">' .. "off" .. "</span>"
      )
    end

    text_status:set_markup_silently(
      string.format('<span color="%s" font="%s">%s</span>', colors.white, font(11), on_off(on_status))
    )
  end)

  local final_container = wibox.widget {
    {
      button_container,
      text_button,
      layout = wibox.layout.fixed.horizontal,
    },
    widget = wibox.container.margin,
    top = dpi(3),
    bottom = dpi(3),
    left = dpi(2),
    right = 0,
  }

  return final_container
end

local buttons = {
  wifi = create_button(container.wifi, "Wifi", true, "nmcli radio wifi on", "nmcli radio wifi off"),
  bluetooth = create_button(container.bluetooth, "Bluetooth", false, "", ""),
  dnd = create_button(container.dnd, "DND", false, "", ""),
}

--DND Button Functionality
local dnd_on = false
container.dnd:connect_signal("button::press", function()
  dnd_on = not dnd_on
  if dnd_on then
    user.dnd_status = true
  else
    user.dnd_status = false
  end
end)

local button = wibox.widget {
  {
    {
      buttons.wifi,
      buttons.bluetooth,
      buttons.dnd,
      layout = wibox.layout.fixed.vertical,
    },
    widget = wibox.container.margin,
    top = dpi(6),
    bottom = dpi(6),
    right = dpi(3),
    left = dpi(3),
  },
  widget = wibox.container.background,
  bg = color.background_lighter,
  forced_width = dpi(202),
  shape = function(cr, width, height)
    gears.shape.rounded_rect(cr, width, height, 10)
  end,
}

return button
