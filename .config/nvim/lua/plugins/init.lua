return {
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
  {
    "numToStr/Comment.nvim",
    opts = {},
  },
}
