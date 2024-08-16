local awful = require("awful")
local gtable = require("gears.table")

local M = {}

--[[
Formats a table of keyboard shortcuts into a list of AwesomeWM key bindings.

This function iterates over a table of keyboard shortcuts, groups them by category, 
and converts them into key bindings that can be used in AwesomeWM.

@param shortcuts (table):
  A table where each key represents a group name, and each value is a list 
  of bindings. Each binding should have the following structure:
  {
    mods = { modkeys... }, -- (table) Modifier keys (e.g., { "Mod4", "Shift" })
    key = "s",           -- (string) The key to bind (e.g., "s", "Enter")
    fn = some_function,  -- (function) The function to execute when the key is pressed
    description = "show help", -- (string) A description of the shortcut
  }
]]
M.format_shortcuts = function(shortcuts)
	local ret = {}

	for group, binds in pairs(shortcuts) do
		for _, bind in ipairs(binds) do
			ret = gtable.join(
				ret,
				awful.key(bind.mods, bind.key, bind.fn, {
					description = bind.description,
					group = group,
				})
			)
		end
	end

	return ret
end

return M
