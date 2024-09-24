local gears = require "gears"
local awful = require "awful"
local wibox = require "wibox"
local beautiful = require "beautiful"
local dpi = beautiful.xresources.apply_dpi
local colors = beautiful.other.colors
local font = beautiful.other.font
local pref = require "preferences"

local function base_slider(icon, query_cmd, set_fn, min, max)
  local handle_margins = 5

  local slider = wibox.widget {
    widget = wibox.widget.slider,
    bar_shape = function(cr, width, height)
      gears.shape.rounded_rect(cr, width, height, 9999)
    end,
    bar_height = dpi(24),
    bar_color = colors.darkblue,
    handle_shape = gears.shape.circle,
    handle_margins = {
      top = handle_margins,
      bottom = handle_margins,
      left = handle_margins,
      right = handle_margins,
    },
    handle_color = colors.bg_dim,
    handle_width = dpi(24),
    handle_border_color = colors.darkblue,
    minimum = min,
    maximum = max,
  }

  slider:connect_signal("property::value", function(widget)
    set_fn(widget.value)
  end)

  local container = {
    {
      {
        widget = wibox.widget.imagebox,
        image = icon,
        resize = true,
        forced_width = dpi(24),
        forced_height = dpi(24),
      },
      {
        slider,
        widget = wibox.container.margin,
        bottom = dpi(20),
        right = dpi(5),
        left = dpi(5),
      },
      layout = wibox.layout.fixed.horizontal,

      -- values are broken
      -- but without them, the popup fills the whole screen
      -- if set too low, the sliders are not visible or get cut off
      forced_width = dpi(300),
      forced_height = dpi(50),
    },
    widget = wibox.container.margin,
    left = dpi(10),
    right = dpi(10),
  }

  container.update_slider = function()
    awful.spawn.easy_async(query_cmd, function(stdout)
      local value = tonumber(stdout) or 69
      value = math.min(value, max)
      value = math.max(value, min)
      slider.value = value
    end)
  end

  return container
end

local function create_widget(text, icon, query_cmd, set_fn, min, max)
  local slider_widget = base_slider(icon, query_cmd, set_fn, min, max)

  local textbox = wibox.widget {
    {
      markup = string.format('<span color="%s" font="%s">%s</span>', colors.lightblue, font "Bold 11", text),
      widget = wibox.widget.textbox,
    },
    widget = wibox.container.margin,
    top = dpi(10),
    bottom = dpi(12),
    right = dpi(8),
    left = dpi(8),
  }

  local slider = wibox.widget {
    {
      {
        textbox,
        slider_widget,
        layout = wibox.layout.fixed.vertical,
      },
      widget = wibox.container.margin,
      right = dpi(8),
      left = dpi(8),
    },
    widget = wibox.container.background,
    bg = colors.bg_normal,
    shape = function(cr, width, height)
      gears.shape.rounded_rect(cr, width, height, beautiful.settings_buttnons_radius)
    end,
  }

  slider.update = function()
    slider_widget.update_slider()
  end

  slider.update()

  return slider
end

return {
  volume = create_widget(
    "Volume",
    os.getenv "HOME" .. "/.config/awesome/icons/settings/bulb.svg",
    pref.cmds.volume.query_slider,
    pref.cmds.volume.set_slider,
    0,
    95
  ),
  brightness = create_widget(
    "Brightness",
    os.getenv "HOME" .. "/.config/awesome/icons/settings/bulb.svg",
    pref.cmds.brightness.query_slider,
    pref.cmds.brightness.set_slider,
    pref.data.brightness.min_slider,
    pref.data.brightness.max_slider
  ),
}
