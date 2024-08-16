local keys = require("keys")
local awful = require("awful")
local hotkeys_popup = require("awful.hotkeys_popup")
local utils = require("utils")
local config = require("config")

local modkey = require("config").user.modkey

local function notify_brightness()
	utils.exec_after("0.2", function()
		awful.spawn.easy_async("brillo", function(stdout)
			utils.replaceable_notification("Brightness: " .. stdout)
		end)
	end)
end

local function notify_volume()
	utils.exec_after("0.2", function()
		awful.spawn.easy_async("pamixer --get-volume-human", function(stdout)
			utils.replaceable_notification("Volume: " .. stdout)
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
				mymainmenu:show()
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
			key = keys.letter.r,
			fn = function()
				awful.prompt.run({
					prompt = "Search: ",
					textbox = awful.screen.focused().mypromptbox.widget,
					exe_callback = function(query)
						query = query:gsub("%s+", "+")
						local command = string.format('firefox "https://duckduckgo.com/?q=%s"', query)
						awful.spawn(command)
					end,
				})
			end,
			description = "search online",
		},
	},

	tag = {
		{
			mods = { modkey },
			key = keys.arrow.left,
			fn = awful.tag.viewprev,
			description = "view previous",
		},
		{
			mods = { modkey },
			key = keys.arrow.right,
			fn = awful.tag.viewnext,
			description = "view next",
		},
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
				awful.spawn(config.apps.terminal)
			end,
			description = "open terminal",
		},
		{
			mods = { keys.mod.alt },
			key = keys.special.space,
			fn = function()
				awful.spawn("rofi -show drun")
			end,
			description = "open desktop app",
		},
		{
			mods = { keys.mod.alt },
			key = keys.special.tab,
			fn = function()
				awful.spawn("rofi -show window")
			end,
			description = "switch app",
		},
		{
			mods = { modkey },
			key = keys.letter.x,
			fn = function()
				awful.spawn("rofi -show powermenu -modi powermenu:~/.config/scripts/rofi-power-menu")
			end,
			description = "open power menu",
		},
		{
			mods = { modkey },
			key = keys.letter.e,
			fn = function()
				awful.spawn(config.apps.file_exp)
			end,
			description = "open file explorer",
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
				awful.spawn("pamixer -t")
				notify_volume()
			end,
			description = "toggle mute",
		},
		{
			mods = {},
			key = keys.xf86.audio.volume.down,
			fn = function()
				awful.spawn("pamixer -u -d 5")
				notify_volume()
			end,
			description = "lower volume",
		},
		{
			mods = {},
			key = keys.xf86.audio.volume.up,
			fn = function()
				awful.spawn("pamixer -u -i 5")
				notify_volume()
			end,
			description = "raise volume",
		},
		{
			mods = {},
			key = keys.xf86.audio.prev,
			fn = function()
				awful.spawn("playerctl previous")
			end,
			description = "play previous",
		},
		{
			mods = {},
			key = keys.xf86.audio.pause,
			fn = function()
				awful.spawn("playerctl play-pause")
			end,
			description = "toggle play",
		},
		{
			mods = {},
			key = keys.xf86.audio.next,
			fn = function()
				awful.spawn("playerctl next")
			end,
			description = "play next",
		},
	},

	other = {
		{
			mods = { modkey, keys.mod.shift },
			key = keys.letter.x,
			fn = function()
				awful.spawn.with_shell("~/.config/scripts/lock.sh")
			end,
			description = "lock screen",
		},
		{
			mods = {},
			key = keys.xf86.brightness.down,
			fn = function()
				awful.spawn("brillo -q -U 5 -u 150000")
				notify_brightness()
			end,
			description = "decrease brightness",
		},
		{
			mods = {},
			key = keys.xf86.brightness.up,
			fn = function()
				awful.spawn("brillo -q -A 5 -u 150000")
				notify_brightness()
			end,
			description = "increase brightness",
		},
		{
			mods = {},
			key = keys.special.print,
			fn = function()
				awful.spawn("flameshot screen")
			end,
			description = "take screenshot",
		},
		{
			mods = { modkey, keys.mod.shift },
			key = keys.letter.s,
			fn = function()
				awful.spawn("flameshot gui")
			end,
			description = "open screenshot gui",
		},
	},
}
