local awful = require "awful"

local keys = require "keys"
local pref = require "preferences"
local modkey = pref.user.modkey

return {
  client = {
    {
      mods = { modkey },
      key = keys.letter.f,
      fn = function(c)
        c.fullscreen = not c.fullscreen
        c:raise()
      end,
      description = "toggle fullscreen",
    },
    {
      mods = { modkey },
      key = keys.letter.q,
      fn = function(c)
        c:kill()
      end,
      description = "close",
    },
    {
      mods = { modkey, keys.mod.ctrl },
      key = keys.special.space,
      fn = awful.client.floating.toggle,
      description = "toggle floating",
    },
    {
      mods = { modkey, keys.mod.ctrl },
      key = keys.special.enter,
      fn = function(c)
        c:swap(awful.client.getmaster())
      end,
      description = "move to master",
    },
    {
      mods = { modkey },
      key = keys.letter.o,
      fn = function(c)
        c:move_to_screen()
      end,
      description = "move to screen",
    },
    {
      mods = { modkey },
      key = keys.letter.t,
      fn = function(c)
        c.ontop = not c.ontop
      end,
      description = "toggle keep on top",
    },
    {
      mods = { modkey },
      key = keys.letter.n,
      fn = function(c)
        c.minimized = true
      end,
      description = "minimize",
    },
    {
      mods = { modkey },
      key = keys.letter.m,
      fn = function(c)
        c.maximized = not c.maximized
        c:raise()
      end,
      description = "(un)maximize",
    },
    {
      mods = { modkey, keys.mod.ctrl },
      key = keys.letter.m,
      fn = function(c)
        c.maximized_vertical = not c.maximized_vertical
        c:raise()
      end,
      description = "(un)maximize vertically",
    },
    {
      mods = { modkey, keys.mod.shift },
      key = keys.letter.m,
      fn = function(c)
        c.maximized_horizontal = not c.maximized_horizontal
        c:raise()
      end,
      description = "(un)maximize horizontally",
    },
  },
}
