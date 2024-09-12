-- If LuaRocks is installed, make sure that packages installed through it are
-- found (e.g. lgi). If LuaRocks is not installed, do nothing.
pcall(require, "luarocks.loader")

-- Standard awesome library
local gears = require "gears"
local awful = require "awful"
require "awful.autofocus"
-- Theme handling library
local beautiful = require "beautiful"
-- Notification library
local menubar = require "menubar"

beautiful.init(os.getenv "HOME" .. "/.config/awesome/theme.lua")

require "notifications"
require "signals"
require "rules"

local pref = require "preferences"
local modkey = pref.user.modkey
local menu = require "menu"

awful.layout.layouts = pref.layouts

menubar.utils.terminal = pref.apps.terminal

require "topbar"

-- {{{ Mouse bindings
root.buttons(gears.table.join(
  awful.button({}, 3, function()
    menu:toggle()
  end),
  awful.button({}, 4, awful.tag.viewnext),
  awful.button({}, 5, awful.tag.viewprev)
))
-- }}}

local globalkeys = require("binds.common").format_shortcuts(require "binds.global")

-- {{{ Key bindings

-- Bind all key numbers to tags.
-- Be careful: we use keycodes to make it work on any keyboard layout.
-- This should map on the top row of your keyboard, usually 1 to 9.
for i = 1, 9 do
  globalkeys = gears.table.join(
    globalkeys,
    -- View tag only.
    awful.key({ modkey }, i, function()
      local screen = awful.screen.focused()
      local tag = screen.tags[i]
      if tag then
        tag:view_only()
      end
    end, { description = "view tag #" .. i, group = "tag" }),
    -- Toggle tag display.
    awful.key({ modkey, "Control" }, i, function()
      local screen = awful.screen.focused()
      local tag = screen.tags[i]
      if tag then
        awful.tag.viewtoggle(tag)
      end
    end, { description = "toggle tag #" .. i, group = "tag" }),
    -- Move client to tag.
    awful.key({ modkey, "Shift" }, "#" .. i + 9, function()
      if client.focus then
        local tag = client.focus.screen.tags[i]
        if tag then
          client.focus:move_to_tag(tag)
        end
      end
    end, { description = "move focused client to tag #" .. i, group = "tag" }),
    -- Toggle tag on focused client.
    awful.key({ modkey, "Control", "Shift" }, "#" .. i + 9, function()
      if client.focus then
        local tag = client.focus.screen.tags[i]
        if tag then
          client.focus:toggle_tag(tag)
        end
      end
    end, { description = "toggle focused client on tag #" .. i, group = "tag" })
  )
end

clientbuttons = gears.table.join(
  awful.button({}, 1, function(c)
    c:emit_signal("request::activate", "mouse_click", { raise = true })
  end),
  awful.button({ modkey }, 1, function(c)
    c:emit_signal("request::activate", "mouse_click", { raise = true })
    awful.mouse.client.move(c)
  end),
  awful.button({ modkey }, 3, function(c)
    c:emit_signal("request::activate", "mouse_click", { raise = true })
    awful.mouse.client.resize(c)
  end)
)

root.keys(globalkeys)

-- Auto run commands

local startup = pref.startup

for _, cmd in ipairs(startup) do
  awful.spawn.with_shell(cmd)
end

do
  local naughty = require "naughty"

  -- Error handling
  if awesome.startup_errors then
    naughty.notify {
      preset = naughty.config.presets.critical,
      title = "Oops, there were errors during startup!",
      text = awesome.startup_errors,
    }
  end
end
