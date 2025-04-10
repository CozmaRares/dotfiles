require "nvchad.options"

local o = vim.opt

o.relativenumber = true
o.number = true
o.spell = false
o.signcolumn = "auto"
o.wrap = false
o.guicursor = ""
o.tabstop = 4
o.softtabstop = 4
o.expandtab = true
o.shiftwidth = 0
o.smartindent = true
o.hlsearch = false
o.incsearch = true
o.termguicolors = true
o.scrolloff = 8
o.updatetime = 50
o.swapfile = false
o.backup = false
o.undodir = os.getenv "HOME" .. "/.cache/nvim/undodir"
o.undofile = true
o.list = true
o.listchars = {
  space = "·",
  tab = ">~",
  trail = "×",
  eol = "¬",
}
