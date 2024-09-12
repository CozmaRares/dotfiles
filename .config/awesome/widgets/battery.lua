-------------------------------------------------
-- Battery Arc Widget for Awesome Window Manager
-- Shows the battery level of the laptop
-- More details could be found here:
-- https://github.com/streetturtle/awesome-wm-widgets/tree/master/batteryarc-widget

-- @author Pavel Makhov
-- @copyright 2020 Pavel Makhov
-------------------------------------------------

local awful = require "awful"
local beautiful = require "beautiful"
local naughty = require "naughty"
local wibox = require "wibox"
local watch = require "awful.widget.watch"
local colors = beautiful.other.colors

local icon_path = os.getenv "HOME" .. "/.config/awesome/icons/other/rocket.svg"

local batteryarc_widget = {}

return function()
  local font = beautiful.other.font(8)
  local arc_thickness = 2
  local size = 26
  local timeout = 10

  local main_color = beautiful.fg_color
  local bg_color = "#ffffff11"
  local low_level_color = colors.red
  local medium_level_color = colors.purple
  local high_level_color = colors.blue
  local charging_color = colors.blue

  local warning_msg_title = "Houston, we have a problem"
  local warning_msg_text = "Battery is dying"
  local warning_msg_position = "bottom_right"
  local warning_msg_icon = icon_path

  local inner_text = wibox.widget.textbox()
  local text = wibox.widget {
    inner_text,
    widget = wibox.container.margin,
    left = 1,
    font = font,
    align = "center",
    valign = "center",
  }

  local text_with_background = wibox.container.background(text)

  batteryarc_widget = wibox.widget {
    text_with_background,
    max_value = 100,
    rounded_edge = true,
    thickness = arc_thickness,
    start_angle = 4.71238898, -- 2pi*3/4
    forced_height = size,
    forced_width = size,
    bg = bg_color,
    paddings = 2,
    widget = wibox.container.arcchart,
  }

  local last_battery_check = os.time()

  --[[ Show warning notification ]]
  local function show_battery_warning()
    naughty.notify {
      icon = warning_msg_icon,
      icon_size = 100,
      text = warning_msg_text,
      title = warning_msg_title,
      timeout = 25, -- show the warning for a longer time
      hover_timeout = 0.5,
      position = warning_msg_position,
      bg = "#F06060",
      fg = "#EEE9EF",
      width = 300,
    }
  end

  local function update_widget(widget, stdout)
    local charge = 0
    local status
    for s in stdout:gmatch "[^\r\n]+" do
      local cur_status, charge_str, _ = string.match(s, ".+: ([%a%s]+), (%d?%d?%d)%%,?(.*)")
      if cur_status ~= nil and charge_str ~= nil then
        local cur_charge = tonumber(charge_str) or 0
        if cur_charge > charge then
          status = cur_status
          charge = cur_charge
        end
      end
    end

    widget.value = charge

    if status == "Charging" then
      text_with_background.bg = charging_color
      text_with_background.fg = "#000000"
    else
      text_with_background.bg = "#00000000"
      text_with_background.fg = main_color
    end

    inner_text.text = charge == 100 and "" or string.format("%d", charge)

    if charge < 15 then
      widget.colors = { low_level_color }
      if status ~= "Charging" and os.difftime(os.time(), last_battery_check) > 300 then
        last_battery_check = os.time()
        show_battery_warning()
      end
    elseif charge < 40 then
      widget.colors = { medium_level_color }
    else
      widget.colors = { high_level_color }
    end
  end

  watch("acpi", timeout, update_widget, batteryarc_widget)
  local notification_id = require("notif_ids").battery

  local function show_battery_status()
    awful.spawn.easy_async("acpi", function(stdout)
      naughty.notify {
        text = stdout,
        title = "Battery",
        timeout = 5,
        id = notification_id,
        replaces_id = notification_id,
      }
    end)
  end

  batteryarc_widget:connect_signal("button::press", function(_, _, _, button)
    if button == 1 then
      show_battery_status()
    end
  end)

  return batteryarc_widget
end
