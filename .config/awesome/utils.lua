local awful = require("awful")
local naughty = require("naughty")

local M = {}

--[[
Creates or updates a notification.

@param: text (string): The content of the notification.
]]
M.replaceable_notification = function(text)
	naughty.notify({
		id = 1,
		replaces_id = 1,
		text = text:gsub("\n$", ""),
	})
end

--[[
Executes a function after a specified delay.

@param sleep (string): The delay in seconds before the function is executed.
@param fn (function): The function to execute after the delay.
]]
M.exec_after = function(sleep, fn)
	awful.spawn.easy_async("sleep " .. sleep, fn)
end

return M
