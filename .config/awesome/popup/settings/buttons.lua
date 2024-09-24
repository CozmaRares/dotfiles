local awful = require "awful"
local wibox = require "wibox"
local gshape = require "gears.shape"
local beautiful = require "beautiful"
local dpi = beautiful.xresources.apply_dpi
local colors = beautiful.other.colors
local font = beautiful.other.font
local pref = require "preferences"

local function create_button(text, icon, script_path)
  local function on_off(status)
    local text_status = "Off"

    if status == true then
      text_status = "On"
    end

    return string.format('<span color="%s" font="%s">%s</span>', colors.white, font(11), text_status)
  end

  local on_status = false

  local bg_colors = {
    on = colors.darkblue,
    off = colors.bg_dark,
  }

  local text_status = wibox.widget {
    markup = on_off(on_status),
    widget = wibox.widget.textbox,
  }

  local title = wibox.widget {
    markup = string.format('<span color="%s" font="%s">%s</span>', colors.lightblue, font "Bold 14", text),
    widget = wibox.widget.textbox,
  }

  local button_image = wibox.widget {
    {
      {
        image = os.getenv "HOME" .. "/.config/awesome/icons/settings/" .. icon .. ".svg",
        widget = wibox.widget.imagebox,
        resize = true,
        forced_height = dpi(24),
        forced_width = dpi(24),
        shape = function(cr, width, height)
          gshape.circle(cr, width, height)
        end,
      },
      widget = wibox.container.margin,
      top = dpi(10),
      bottom = dpi(10),
      left = dpi(10),
      right = dpi(10),
    },
    widget = wibox.container.background,
    bg = (on_status and bg_colors.on) or bg_colors.off,
    shape = function(cr)
      gshape.rounded_bar(cr, dpi(44), dpi(44))
    end,
  }

  local container = wibox.widget {
    {
      {
        button_image,
        {
          {
            title,
            text_status,
            layout = wibox.layout.fixed.vertical,
          },
          widget = wibox.container.margin,
          left = dpi(8),
          right = dpi(16),
        },
        layout = wibox.layout.fixed.horizontal,
      },
      widget = wibox.container.margin,
      top = dpi(8),
      bottom = dpi(8),
      right = dpi(8),
      left = dpi(8),
    },
    widget = wibox.container.background,
    bg = colors.bg_normal,
    shape = function(cr, width, height)
      gshape.rounded_rect(cr, width, height, beautiful.settings_buttnons_radius)
    end,
  }

  container.toggle = function()
    on_status = not on_status

    if on_status then
      button_image:set_bg(bg_colors.on)
      awful.spawn.with_shell(script_path .. "on")
    else
      button_image:set_bg(bg_colors.off)
      awful.spawn.with_shell(script_path .. "off")
    end

    text_status:set_markup_silently(on_off(on_status))
  end

  container.refresh = function()
    awful.spawn.easy_async_with_shell(script_path .. "query", function(stdout)
      on_status = string.sub(stdout, 1, 1) == "1"
      if on_status then
        button_image:set_bg(bg_colors.on)
      else
        button_image:set_bg(bg_colors.off)
      end
      text_status:set_markup_silently(on_off(on_status))
    end)
  end

  button_image:connect_signal("button::press", function()
    container.toggle()
  end)

  return container
end

return {
  wifi = create_button("Wifi", "wifi", pref.cmds.services.wifi),
  bluetooth = create_button("Bluetooth", "bluetooth", pref.cmds.services.bluetooth),
  silent = create_button("Silent", "speaker_off", pref.cmds.services.silent),
  nightmode = create_button("Night Mode", "moon", pref.cmds.services.nightmode),
}
