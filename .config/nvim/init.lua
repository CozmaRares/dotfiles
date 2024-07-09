local nvim = vim

nvim.g.base46_cache = nvim.fn.stdpath "data" .. "/nvchad/base46/"
nvim.g.mapleader = " "

-- bootstrap lazy and all plugins
local lazypath = nvim.fn.stdpath "data" .. "/lazy/lazy.nvim"

if not nvim.loop.fs_stat(lazypath) then
  local repo = "https://github.com/folke/lazy.nvim.git"
  nvim.fn.system { "git", "clone", "--filter=blob:none", repo, "--branch=stable", lazypath }
end

nvim.opt.rtp:prepend(lazypath)

local lazy_config = require "configs.lazy"

-- load plugins
require("lazy").setup({
  {
    "NvChad/NvChad",
    lazy = false,
    branch = "v2.5",
    import = "nvchad.plugins",
    config = function()
      require "options"
    end,
  },

  { import = "plugins" },
}, lazy_config)

-- load theme
dofile(nvim.g.base46_cache .. "defaults")
dofile(nvim.g.base46_cache .. "statusline")

require "nvchad.autocmds"

nvim.schedule(function()
  require "mappings"
end)

require("polish")
