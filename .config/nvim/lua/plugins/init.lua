return {
  {
    "Pocco81/auto-save.nvim",
    lazy = false,
    opts = {
      trigger_events = { "InsertLeave", "TextChanged" }, -- vim events that trigger auto-save. See :h events
      -- function that determines whether to save the current buffer or not
      -- return true: if buffer is ok to be saved
      -- return false: if it's not ok to be saved
      condition = function(buf)
        local fn = vim.fn
        local utils = require "auto-save.utils.data"

        if fn.getbufvar(buf, "&modifiable") == 1 and utils.not_in(fn.getbufvar(buf, "&filetype"), {}) then
          return true -- met condition(s), can save
        end
        return false -- can't save
      end,
      write_all_buffers = false, -- write all buffers when the current one meets `condition`
      debounce_delay = 5000, -- saves the file at most every `debounce_delay` milliseconds
      callbacks = { -- functions to be executed at different intervals
        enabling = nil, -- ran when enabling auto-save
        disabling = nil, -- ran when disabling auto-save
        before_asserting_save = nil, -- ran before checking `condition`
        before_saving = nil, -- ran before doing the actual save
        after_saving = nil, -- ran after doing the actual save
      },
    },
  },
  {
    "alexghergh/nvim-tmux-navigation",
    opts = {
      disable_when_zoomed = true,
    },
  },
  {
    "folke/todo-comments.nvim",
    lazy = false,
    opts = {},
    cmd = { "TodoTelescope" },
  },
  {
    "mbbill/undotree",
    lazy = false,
  },
  {
    "NMAC427/guess-indent.nvim",
    opts = {},
    lazy = false,
  },
  {
    "rcarriga/nvim-notify",
    lazy = false,
    opts = {
      background_colour = "#000000",
    },
    config = function(_, opts)
      require("notify").setup(opts)
      local banned_messages = { eq = { "No information available" }, starts = { "rust_analyzer" } }
      vim.notify = function(msg, ...)
        for _, banned in ipairs(banned_messages.eq) do
          if msg == banned then
            return
          end
        end
        for _, banned in ipairs(banned_messages.starts) do
          if msg:find("^" .. banned) ~= nil then
            return
          end
        end
        return require "notify"(msg, ...)
      end
    end,
  },
}
