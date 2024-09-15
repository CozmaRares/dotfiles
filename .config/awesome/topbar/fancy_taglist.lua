-- awesomewm fancy_taglist: a taglist that contains a tasklist for each tag.
-- Usage (add s.mytaglist to the wibar):
-- awful.screen.connect_for_each_screen(function(s)
--     ...
--     local fancy_taglist = require("fancy_taglist")
--     s.mytaglist = fancy_taglist.new({
--         screen = s,
--         taglist = { buttons = mytagbuttons },
--         tasklist = { buttons = mytasklistbuttons }
--     })
--     ...
-- end)
--
-- If you want rounded corners, try this in your theme:
-- theme.taglist_shape = function(cr, w, h)
--     return gears.shape.rounded_rect(cr, w, h, theme.border_radius)
-- end
local awful = require "awful"
local beautiful = require "beautiful"
local gears = require "gears"
local wibox = require "wibox"
local menubar = require "menubar"

local dpi = beautiful.xresources.apply_dpi

local DEFAULT_ICON = os.getenv "HOME" .. "/.config/awesome/icons/other/default_app_icon.svg"

local function box_margins(widget, margins)
  margins = margins or {}

  return {
    { widget, widget = wibox.container.place },
    top = margins.top or 0,
    bottom = margins.bottom or 0,
    left = margins.left or 0,
    right = margins.right or 0,
    widget = wibox.container.margin,
    id = margins.id,
  }
end

local function fancy_tasklist(cfg, tag)
  local function only_this_tag(c, _)
    for _, t in ipairs(c:tags()) do
      if t == tag then
        return true
      end
    end
    return false
  end

  local overrides = {
    filter = only_this_tag,
    layout = {
      layout = wibox.layout.fixed.horizontal,
    },
    widget_template = {
      widget = wibox.widget.imagebox,
      create_callback = function(self, c, _, _)
        self.image = menubar.utils.lookup_icon(c.class)
          or menubar.utils.lookup_icon(string.lower(c.instance))
          or c.icon
          or DEFAULT_ICON
      end,
    },
  }
  return awful.widget.tasklist(gears.table.join(cfg, overrides))
end

local module = {}

-- @param cfg.screen
-- @param cfg.tasklist -> see awful.widget.tasklist
-- @param cfg.taglist  -> see awful.widget.taglist
function module.new(cfg)
  cfg = cfg or {}
  local taglist_cfg = cfg.taglist or {}
  local tasklist_cfg = cfg.tasklist or {}

  local screen = cfg.screen or awful.screen.focused()
  taglist_cfg.screen = screen
  tasklist_cfg.screen = screen

  local function update_callback(self, tag, _, _)
    -- make sure that empty tasklists take up no extra space
    local text_margin = self:get_children_by_id("text_margin")[1]
    if #tag:clients() == 0 then
      text_margin.right = 0
    else
      text_margin.right = dpi(5)
    end
  end

  local function create_callback(self, tag, _index, _tags)
    local tasklist = fancy_tasklist(tasklist_cfg, tag)
    self:get_children_by_id("tasklist_placeholder")[1]:add(tasklist)
    update_callback(self, tag, _index, _tags)
  end

  local overrides = {
    filter = awful.widget.taglist.filter.all,
    widget_template = {
      box_margins({
        box_margins({
          id = "text_role",
          widget = wibox.widget.textbox,
          align = "center",
        }, {
          right = dpi(5),
          id = "text_margin",
        }),
        {
          id = "tasklist_placeholder",
          layout = wibox.layout.fixed.horizontal,
        },
        id = "list_separator",
        spacing = 0,
        layout = wibox.layout.fixed.horizontal,
      }, {
        top = dpi(5),
        bottom = dpi(5),
        left = dpi(8),
        right = dpi(8),
      }),

      id = "background_role",
      widget = wibox.container.background,
      create_callback = create_callback,
      update_callback = update_callback,
    },
  }

  return awful.widget.taglist(gears.table.join(taglist_cfg, overrides))
end

return module
