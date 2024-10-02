local theme_assets = require "beautiful.theme_assets"
local xresources = require "beautiful.xresources"
local dpi = xresources.apply_dpi
local gfs = require "gears.filesystem"
local gshape = require "gears.shape"
local themes_path = gfs.get_themes_dir()

local colors = {
  bg_dark = "#1a1b26",
  bg_dim = "#212539",
  bg_normal = "#24283b",
  bg_light = "#36424c",
  mid_dark = "#414b68",
  mid_normal = "#565f89",
  mid_light = "#9aa5ce",
  fg_normal = "#a9b1d6",
  red = "#f7768e",
  orange = "#ff9e64",
  yellow = "#e0af68",
  green = "#9ece6a",
  cyan = "#7dcfff",
  darkblue = "#3d59a1",
  lightblue = "#89b4fa",
  blue = "#7aa2f7",
  magenta = "#8c43f1",
  purple = "#bb9af7",
  white = "#ffffff",
  -- TODO: refactor colros
  -- https://lospec.com/palette-list/tokyo-night
}

local function font(modifiers)
  return "JetBrainsMono NF " .. modifiers
end

local theme = {}

theme.font = font(8)

theme.bg_normal = colors.bg_normal
theme.bg_focus = colors.mid_light
theme.bg_urgent = colors.red
theme.bg_minimize = colors.bg_dark
theme.bg_systray = theme.bg_normal

theme.fg_normal = colors.fg_normal
theme.fg_focus = colors.white
theme.fg_urgent = colors.white
theme.fg_minimize = colors.white

theme.useless_gap = dpi(8)
theme.border_width = dpi(2)
theme.border_normal = colors.bg_dark
theme.border_focus = colors.mid_dark
theme.border_marked = colors.orange

theme.fg = colors.fg_normal
theme.bg = colors.bg_dark
theme.bg_normal = colors.bg_dark
theme.fg_normal = colors.mid_light
theme.bg_focus = colors.mid_dark
theme.fg_focus = colors.fg_normal
theme.border_width = 2
theme.border_normal = colors.bg_normal
theme.border_focus = colors.mid_normal

theme.titlebar_bg = colors.bg_normal
theme.titlebar_bg_focus = colors.mid_normal

theme.taglist_bg_empty = colors.bg_dim
theme.taglist_bg_occupied = colors.bg_dim
theme.taglist_bg_focus = colors.bg_light

theme.taglist_fg_empty = colors.mid_normal
theme.taglist_fg_occupied = colors.fg_normal
theme.taglist_fg_focus = colors.cyan
theme.taglist_fg_urgent = colors.red

theme.taglist_spacing = dpi(7)

theme.wibar_bg = colors.bg_dark
theme.wibar_height = dpi(25)
theme.wibar_position = "top"

theme.bg_systray = colors.bg_dark
theme.systray_icon_spacing = dpi(10)

theme.taglist_shape = function(cr, w, h)
  return gshape.rounded_rect(cr, w, h, 9999)
end

theme.menu_submenu_icon = themes_path .. "default/submenu.png"
theme.menu_font = font(12)
theme.menu_height = dpi(30)
theme.menu_width = dpi(200)
theme.menu_border_color = colors.bg_dark
theme.menu_border_width = dpi(2)
theme.menu_fg_focus = colors.cyan
theme.menu_bg_focus = colors.bg_light .. "90"
theme.menu_fg_normal = colors.fg_normal
theme.menu_bg_normal = colors.bg_dark .. "90"

-- titlebar icon path
local tip = os.getenv "HOME" .. "/.config/awesome/icons/titlebar/"

theme.titlebar_close_button_normal = tip .. "x.svg"
theme.titlebar_close_button_focus = tip .. "x.svg"

theme.titlebar_close_button_normal_hover = tip .. "x_full.svg"
theme.titlebar_close_button_focus_hover = tip .. "x_full.svg"

theme.titlebar_maximized_button_normal_inactive = tip .. "plus.svg"
theme.titlebar_maximized_button_focus_inactive = tip .. "plus.svg"

theme.titlebar_maximized_button_normal_inactive_hover = tip .. "plus_full.svg"
theme.titlebar_maximized_button_focus_inactive_hover = tip .. "plus_full.svg"

theme.titlebar_maximized_button_normal_active = tip .. "minus.svg"
theme.titlebar_maximized_button_focus_active = tip .. "minus.svg"

theme.titlebar_maximized_button_normal_active_hover = tip .. "minus_full.svg"
theme.titlebar_maximized_button_focus_active_hover = tip .. "minus_full.svg"

theme.titlebar_sticky_button_focus_active = tip .. "pin_full.svg"
theme.titlebar_sticky_button_normal_active = tip .. "pin_full.svg"

theme.titlebar_sticky_button_focus_active_hover = tip .. "pin_slash_full.svg"
theme.titlebar_sticky_button_normal_active_hover = tip .. "pin_slash_full.svg"

theme.titlebar_sticky_button_focus_inactive = tip .. "pin.svg"
theme.titlebar_sticky_button_normal_inactive = tip .. "pin.svg"

theme.titlebar_sticky_button_focus_inactive_hover = tip .. "pin_full.svg"
theme.titlebar_sticky_button_normal_inactive_hover = tip .. "pin_full.svg"

theme.titlebar_floating_button_focus_active = tip .. "frame_select.svg"
theme.titlebar_floating_button_normal_active = tip .. "frame_select.svg"

theme.titlebar_floating_button_focus_active_hover = tip .. "layout_left.svg"
theme.titlebar_floating_button_normal_active_hover = tip .. "layout_left.svg"

theme.titlebar_floating_button_focus_inactive = tip .. "layout_left.svg"
theme.titlebar_floating_button_normal_inactive = tip .. "layout_left.svg"

theme.titlebar_floating_button_focus_inactive_hover = tip .. "frame_select.svg"
theme.titlebar_floating_button_normal_inactive_hover = tip .. "frame_select.svg"

-- layout icon path
local lip = os.getenv "HOME" .. "/.config/awesome/icons/layouts/"

theme.layout_fairh = lip .. "fairh.png"
theme.layout_fairv = lip .. "fairv.png"
theme.layout_floating = lip .. "floating.png"
theme.layout_magnifier = lip .. "magnifier.png"
theme.layout_max = lip .. "max.png"
theme.layout_fullscreen = lip .. "fullscreen.png"
theme.layout_tilebottom = lip .. "tilebottom.png"
theme.layout_tileleft = lip .. "tileleft.png"
theme.layout_tile = lip .. "tile.png"
theme.layout_tiletop = lip .. "tiletop.png"
theme.layout_spiral = lip .. "spiral.png"
theme.layout_dwindle = lip .. "dwindle.png"
theme.layout_cornernw = lip .. "cornernw.png"
theme.layout_cornerne = lip .. "cornerne.png"
theme.layout_cornersw = lip .. "cornersw.png"
theme.layout_cornerse = lip .. "cornerse.png"

theme.awesome_icon = theme_assets.awesome_icon(theme.menu_height, theme.bg_focus, theme.fg_focus)

theme.hotkeys_bg = colors.bg_dark
theme.hotkeys_fg = colors.lightblue
theme.hotkeys_border_color = colors.cyan
theme.hotkeys_modifiers_fg = colors.purple

theme.icon_theme = "Papirus"

theme.tags = { "1", "2", "3", "4", "5", "6", "7", "8", "9" }
-- theme.tags = { "一", "二", "三", "四", "五", "六", "七", "八", "九" }
-- theme.tags = { "🯱", "🯲", "🯳", "🯴", "🯵", "🯶", "🯷", "🯸", "🯹" }

theme.calendar_radius = dpi(8)

-- TODO: remove other
theme.other = {
  colors = colors,
  font = font,
}

theme.settings_spacing = dpi(12)
theme.settings_buttnons_radius = dpi(10)

return theme
