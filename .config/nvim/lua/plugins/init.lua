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
      local banned_messages = { "No information available" }
      vim.notify = function(msg, ...)
        for _, banned in ipairs(banned_messages) do
          if msg == banned then
            return
          end
        end
        return require "notify"(msg, ...)
      end
    end,
  },
}
