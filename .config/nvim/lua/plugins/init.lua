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
    "luckasRanarison/nvim-devdocs",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope.nvim",
      "nvim-treesitter/nvim-treesitter",
    },
    opts = {
      dir_path = os.getenv "HOME" .. "/.cache/nvim/devdocs",
      after_open = function(bufnr)
        vim.api.nvim_buf_set_keymap(bufnr, "n", "<Esc>", ":close<CR>", {})
      end,
    },
    cmd = {
      "DevdocsFetch",
      "DevdocsInstall",
      "DevdocsUninstall",
      "DevdocsOpen",
      "DevdocsOpenFloat",
      "DevdocsOpenCurrent",
      "DevdocsOpenCurrentFloat",
      "DevdocsToggle",
      "DevdocsUpdate",
      "DevdocsUpdateAll",
    },
  },
}
