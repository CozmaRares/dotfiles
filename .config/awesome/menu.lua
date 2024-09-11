local awful = require "awful"

local pref = require "preferences"
local hotkeys_popup = require "awful.hotkeys_popup"

local awesome_menu = {
  {
    "Hotkeys",
    function()
      hotkeys_popup.show_help(nil, awful.screen.focused())
    end,
  },
  { "Edit Config", pref.cmds.editor .. " " .. awesome.conffile },
  { "Restart", awesome.restart },
  { "Manual", pref.apps.terminal .. " -e man awesome" },
  { "API Docs", "xdg-open https://awesomewm.org/apidoc" },
}

local web_bookmarks = {
  { "YouTube", "xdg-open https://www.youtube.com/" },
  { "ChatGPT", "xdg-open https://chatgpt.com/" },
  { "Discord", "xdg-open https://discord.com/app" },
  { "WhatsApp", "xdg-open https://web.whatsapp.com/" },
  { "ArchWiki", "xdg-open https://wiki.archlinux.org/" },
  { "Chess", "xdg-open https://www.chess.com/" },
  { "MsTeams", "xdg-open https://teams.microsoft.com/" },
  { "Moodle", "xdg-open https://moodle.cs.utcluj.ro/" },
  { "WebSINU", "xdg-open https://websinu.utcluj.ro/" },
}

local file_bookmarks = {
  { "Home", "thunar ~" },
  { "Downloads", "thunar Downloads" },
  { "Dotfiles", "thunar .dotfiles" },
  { "Configs", "thunar .config" },
  { "Wallpapers", "thunar Pictures/Wallpapers/" },
  { "Screen Shots", "thunar Pictures/Screenshots/" },
  { "SSD", "thunar /mnt/SSD/" },
  { "Music", "thunar /mnt/SSD/muzica/" },
  { "Repos", "thunar /mnt/SSD/repos/" },
  { "Sandbox", "thunar /mnt/SSD/sandbox/" },
  { "TUCN", "thunar /mnt/SSD/tucn/" },
  { "Shared", "thunar /mnt/Shared/" },
}

local fav_apps = {
  { "App Launcher", "rofi -show drun" },
  { "Chrome", "google-chrome-unstable" },
  { "Volume Ctrl", "pavucontrol" },
  { "Obsidian", "obsidian" },
  { "Screens Editor", "arandr" },
  { "MsTeams", "teams" },
  { "Zoom", "zoom" },
}

return awful.menu {
  items = {
    { "Awesome", awesome_menu },
    { "Terminal", pref.apps.terminal },
    { "Browser", pref.apps.browser },
    { "Web", web_bookmarks },
    { "Files", file_bookmarks },
    { "Apps", fav_apps },
  },
}
