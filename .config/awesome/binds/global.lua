local awful = require "awful"
local hotkeys_popup = require "awful.hotkeys_popup"
local naughty = require "naughty"
local keys = require "keys"
local pref = require "preferences"
local data = pref.data

local modkey = pref.user.modkey

local function format_brightness(value)
  local bright_min, bright_max = data.brightness.min, data.brightness.max
  value = math.floor((value - bright_min) / (bright_max - bright_min) * 100)
  return value
end

local function notify_brightness()
  awful.spawn.easy_async("sleep 0.2", function()
    awful.spawn.easy_async(pref.cmds.brightness.query, function(stdout)
      stdout = stdout:gsub("\n$", "")
      local val = format_brightness(tonumber(stdout) or data.brightness.min)
      naughty.notify {
        id = data.notif_ids.brightness,
        replaces_id = data.notif_ids.brightness,
        title = "Brightness",
        text = string.format("%9d", val) .. "%",
      }
    end)
  end)
end

local function notify_volume()
  awful.spawn.easy_async("sleep 0.2", function()
    awful.spawn.easy_async(pref.cmds.volume.query, function(stdout)
      stdout = stdout:gsub("\n$", "")
      naughty.notify {
        id = data.notif_ids.volume,
        replaces_id = data.notif_ids.volume,
        title = "Volume",
        text = string.format("%+6s", stdout),
      }
    end)
  end)
end

return {
  awesome = {
    {
      mods = { modkey },
      key = keys.letter.s,
      fn = hotkeys_popup.show_help,
      description = "show help",
    },
    {
      mods = { modkey },
      key = keys.letter.w,
      fn = function()
        require("menu"):show()
      end,
      description = "show main menu",
    },
    {
      mods = { modkey, keys.mod.ctrl },
      key = keys.letter.r,
      fn = awesome.restart,
      description = "reload awesome",
    },
    {
      mods = { modkey },
      key = keys.letter.a,
      fn = function()
        require("popup.settings.main").toggle()
      end,
      description = "show settings menu",
    },
  },

  tag = {
    -- {
    --   mods = { modkey },
    --   key = keys.arrow.left,
    --   fn = awful.tag.viewprev,
    --   description = "view previous",
    -- },
    -- {
    --   mods = { modkey },
    --   key = keys.arrow.right,
    --   fn = awful.tag.viewnext,
    --   description = "view next",
    -- },
    {
      mods = { modkey },
      key = keys.special.esc,
      fn = awful.tag.history.restore,
      description = "go back",
    },
  },

  client = {
    {
      mods = { modkey },
      key = keys.letter.j,
      fn = function()
        awful.client.focus.byidx(1)
      end,
      description = "focus next by index",
    },

    {
      mods = { modkey },
      key = keys.letter.k,
      fn = function()
        awful.client.focus.byidx(-1)
      end,
      description = "focus previous by index",
    },

    {
      mods = { modkey, keys.mod.shift },
      key = keys.letter.j,
      fn = function()
        awful.client.swap.byidx(1)
      end,
      description = "swap with next client by index",
    },

    {
      mods = { modkey, keys.mod.shift },
      key = keys.letter.k,
      fn = function()
        awful.client.swap.byidx(-1)
      end,
      description = "swap with previous client by index",
    },

    {
      mods = { modkey },
      key = keys.letter.k,
      fn = awful.client.urgent.jumpto,
      description = "jump to urgent client",
    },

    {
      mods = { modkey, keys.mod.ctrl },
      key = keys.letter.n,
      fn = function()
        local c = awful.client.restore()
        -- Focus restored client
        if c then
          c:emit_signal("request::activate", "key.unminimize", { raise = true })
        end
      end,
      description = "restore minimized",
    },
  },

  launcher = {
    {
      mods = { modkey },
      key = keys.special.enter,
      fn = function()
        awful.spawn(pref.apps.terminal)
      end,
      description = "open terminal",
    },
    {
      mods = { keys.mod.win },
      key = keys.special.space,
      fn = function()
        awful.spawn(pref.cmds.launcher.apps)
      end,
      description = "open desktop app",
    },
    {
      mods = { keys.mod.alt },
      key = keys.special.tab,
      fn = function()
        awful.spawn(pref.cmds.launcher.alttab)
      end,
      description = "switch app",
    },
    {
      mods = { modkey },
      key = keys.letter.x,
      fn = function()
        awful.spawn(pref.cmds.launcher.powermenu)
      end,
      description = "open power menu",
    },
    {
      mods = { modkey },
      key = keys.letter.e,
      fn = function()
        awful.spawn(pref.apps.file_exp)
      end,
      description = "open file explorer",
    },
    {
      mods = { keys.mod.win },
      key = "p",
      fn = function()
        awful.spawn(pref.apps.screen_editor)
      end,
      description = "open screens layout editor",
    },
  },

  layout = {
    {
      mods = { modkey },
      key = keys.letter.l,
      fn = function()
        awful.tag.incmwfact(0.05)
      end,
      description = "increase master width factor",
    },
    {
      mods = { modkey },
      key = keys.letter.h,
      fn = function()
        awful.tag.incmwfact(-0.05)
      end,
      description = "decrease master width factor",
    },
    {
      mods = { modkey, keys.mod.shift },
      key = keys.letter.h,
      fn = function()
        awful.tag.incnmaster(1, nil, true)
      end,
      description = "increase the number of master clients",
    },
    {
      mods = { modkey, keys.mod.shift },
      key = keys.letter.l,
      fn = function()
        awful.tag.incnmaster(-1, nil, true)
      end,
      description = "decrease the number of master clients",
    },
    {
      mods = { modkey, keys.mod.ctrl },
      key = keys.letter.h,
      fn = function()
        awful.tag.incncol(1, nil, true)
      end,
      description = "increase the number of columns",
    },
    {
      mods = { modkey, keys.mod.ctrl },
      key = keys.letter.l,
      fn = function()
        awful.tag.incncol(-1, nil, true)
      end,
      description = "decrease the number of columns",
    },
    {
      mods = { modkey },
      key = keys.special.space,
      fn = function()
        awful.layout.inc(1)
      end,
      description = "select next",
    },
    {
      mods = { modkey, keys.mod.shift },
      key = keys.special.space,
      fn = function()
        awful.layout.inc(-1)
      end,
      description = "select previous",
    },
  },

  audio = {
    {
      mods = {},
      key = keys.xf86.audio.mute,
      fn = function()
        awful.spawn(pref.cmds.volume.toggle_mute)
        notify_volume()
      end,
      description = "toggle mute",
    },
    {
      mods = {},
      key = keys.xf86.audio.volume.down,
      fn = function()
        awful.spawn(pref.cmds.volume.lower(5))
        notify_volume()
      end,
      description = "lower volume",
    },
    {
      mods = {},
      key = keys.xf86.audio.volume.up,
      fn = function()
        awful.spawn(pref.cmds.volume.raise(5))
        notify_volume()
      end,
      description = "raise volume",
    },
    {
      mods = {},
      key = keys.xf86.audio.prev,
      fn = function()
        awful.spawn(pref.cmds.audio.prev)
      end,
      description = "play previous",
    },
    {
      mods = {},
      key = keys.xf86.audio.pause,
      fn = function()
        awful.spawn(pref.cmds.audio.toggle_play)
      end,
      description = "toggle play",
    },
    {
      mods = {},
      key = keys.xf86.audio.next,
      fn = function()
        awful.spawn(pref.cmds.audio.next)
      end,
      description = "play next",
    },
  },

  other = {
    {
      mods = { modkey, keys.mod.shift },
      key = keys.letter.x,
      fn = function()
        awful.spawn.with_shell(pref.cmds.lock.normal)
      end,
      description = "lock screen",
    },
    {
      mods = {},
      key = keys.xf86.brightness.down,
      fn = function()
        awful.spawn(pref.cmds.brightness.lower(2))
        notify_brightness()
      end,
      description = "decrease brightness",
    },
    {
      mods = {},
      key = keys.xf86.brightness.up,
      fn = function()
        awful.spawn(pref.cmds.brightness.raise(2))
        notify_brightness()
      end,
      description = "increase brightness",
    },
    {
      mods = {},
      key = keys.special.print,
      fn = function()
        awful.spawn(pref.cmds.screenshot.screen)
      end,
      description = "take screenshot",
    },
    {
      mods = { keys.mod.win, keys.mod.shift },
      key = keys.letter.s,
      fn = function()
        awful.spawn(pref.cmds.screenshot.gui)
      end,
      description = "open screenshot gui",
    },
  },
}
