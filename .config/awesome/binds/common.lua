local awful = require("awful")
local gtable = require("gears.table")

local M = {}

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
