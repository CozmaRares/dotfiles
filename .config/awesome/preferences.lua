local keys = require "keys"
local awful = require "awful"

local M = {}

M.apps = {
  browser = "firefox",
  terminal = "kitty",
  editor = "nvim",
  file_exp = "thunar",
  screen_editor = "arandr",
}

M.cmds = {
  editor = M.apps.terminal .. " " .. M.apps.editor,
  brightness = {
    min = "brillo -c -q",
    max = "brillo -m -q",
    query = "brillo -q",
    lower = function(percent)
      return string.format("brillo -q -U %d -u 150000", percent)
    end,
    raise = function(percent)
      return string.format("brillo -q -A %d -u 150000", percent)
    end,

    query_slider = "brillo",
    min_slider = "brillo -c",
    max_slider = "brillo -m",
    set_slider = function(value)
      awful.spawn("brillo -S " .. value)
    end,
  },
  volume = {
    query = "pamixer --get-volume-human",
    toggle_mute = "pamixer -t",
    lower = function(percent)
      return string.format("pamixer -u -d %d --allow-boost", percent)
    end,
    raise = function(percent)
      return string.format("pamixer -u -i %d --allow-boost", percent)
    end,

    query_slider = "pamixer --get-volume",
    set_slider = function(value)
      awful.spawn("pamixer --set-volume " .. value)
    end,
  },
  audio = {
    next = "playerctl next",
    prev = "playerctl previous",
    toggle_play = "playerctl play-pause",
  },
  launcher = {
    apps = "rofi -show drun",
    alttab = "rofi -show window",
    powermenu = "rofi -show powermenu -modi powermenu:~/.config/scripts/rofi-power-menu",
    wifi = "~/.config/scripts/rofi-wifi-menu.sh",
    bluetooth = "~/.config/scripts/rofi-bluetooth",
  },
  lock = {
    normal = "~/.config/scripts/lock/with_ss.sh",
    watch = "~/.config/scripts/lock/watch.sh",
  },
  screenshot = {
    gui = "flameshot gui",
    screen = "flameshot screen",
  },
  services = {
    nightmode = "~/.config/scripts/awesome/nightmode ",
    wifi = "~/.config/scripts/awesome/wifi ",
    bluetooth = "~/.config/scripts/awesome/bluetooth ",
    silent = "~/.config/scripts/awesome/silent ",
  },
  journalctl = "~/.config/scripts/journal",
}

M.data = {
  brightness = {},
}

M.user = {
  modkey = keys.mod.alt,
}

M.startup = {
  "picom",
  "jamesdsp --tray",
  "xss-lock -s " .. os.getenv "XDG_SESSION_ID" .. " -- " .. M.cmds.lock.watch,
  M.cmds.services.nightmode .. "on",
}

M.layouts = {
  awful.layout.suit.tile.left,
  awful.layout.suit.floating,
  awful.layout.suit.fair.horizontal,
  -- awful.layout.suit.tile,
  -- awful.layout.suit.tile.bottom,
  -- awful.layout.suit.tile.top,
  -- awful.layout.suit.fair,
  -- awful.layout.suit.spiral,
  -- awful.layout.suit.spiral.dwindle,
  -- awful.layout.suit.max,
  -- awful.layout.suit.max.fullscreen,
  -- awful.layout.suit.magnifier,
  -- awful.layout.suit.corner.nw,
  -- awful.layout.suit.corner.ne,
  -- awful.layout.suit.corner.sw,
  -- awful.layout.suit.corner.se,
}

awful.spawn.easy_async(M.cmds.brightness.min, function(stdout)
  M.data.brightness.min = tonumber(stdout) or 0
end)

awful.spawn.easy_async(M.cmds.brightness.max, function(stdout)
  M.data.brightness.max = tonumber(stdout) or 100
end)

awful.spawn.easy_async(M.cmds.brightness.min_slider, function(stdout)
  M.data.brightness.min_slider = tonumber(stdout) or 0
end)

awful.spawn.easy_async(M.cmds.brightness.max_slider, function(stdout)
  M.data.brightness.max_slider = tonumber(stdout) or 100
end)

do
  local id = 0

  local function iota()
    id = id + 1
    return id
  end

  M.data.notif_ids = {
    volume = iota(),
    brightness = iota(),
    battery = iota(),
  }
end

return M
