local keys = require("keys")

local M = {}

M.apps = {}

M.user = {
	modkey = keys.mod.win,
}

M.startup = {
	"picom",
	"nitrogen --random --set-zoom-fill ~/Pictures/Wallpapers",
	"redshift -P -O 3000",
	-- "jamesdsp"
}

return M
