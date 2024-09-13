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

local batteryarc_widget = {}

return function()
  local font = beautiful.other.font(8)
  local arc_thickness = 2
  local size = 26
  local timeout = 60
  local warning_cooldown = 5 * 60

  local warning_msg_title = "Houston, we have a problem"
  local warning_msg_text = "Battery is dying"
  local warning_msg_icon = os.getenv "HOME" .. "/.config/awesome/icons/other/battery.png"

  local inner_text = wibox.widget {
    widget = wibox.widget.textbox,
  }
  local text = wibox.widget {
    inner_text,
    widget = wibox.container.margin,
    left = 1,
    font = font,
  }

  batteryarc_widget = wibox.widget {
    text,
    max_value = 100,
    rounded_edge = true,
    thickness = arc_thickness,
    start_angle = 4.71238898, -- 2pi*3/4
    forced_height = size,
    forced_width = size,
    paddings = 2,
    widget = wibox.container.arcchart,
  }

  local last_battery_check = os.time()
  local notification_id = require("notif_ids").battery

  --[[ Show warning notification ]]
  local function show_battery_warning()
    naughty.notify {
      icon = warning_msg_icon,
      text = warning_msg_text,
      title = warning_msg_title,
      icon_size = 50,
      timeout = 25, -- show the warning for a longer time
      hover_timeout = 0.5,
      bg = colors.red,
      fg = colors.bg_dim,
      id = notification_id,
      replaces_id = notification_id,
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

    if charge < 10 then
      inner_text.text = string.format("0%d", charge)

      if status == "Discharging" and os.difftime(os.time(), last_battery_check) > warning_cooldown then
        last_battery_check = os.time()
        show_battery_warning()
      end
    elseif charge < 100 then
      inner_text.text = string.format("%d", charge)
    else
      inner_text.text = "=="
    end

    if status == "Charging" then
      widget.colors = { colors.green }
    elseif charge < 10 then
      widget.colors = { colors.red }
    elseif charge < 30 then
      widget.colors = { colors.purple }
    else
      widget.colors = { colors.blue }
    end
  end

  watch("acpi", timeout, update_widget, batteryarc_widget)

  local function show_battery_status()
    awful.spawn.easy_async("acpi", function(stdout)
      naughty.notify {
        text = string.gsub(stdout, "\n", ""),
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
