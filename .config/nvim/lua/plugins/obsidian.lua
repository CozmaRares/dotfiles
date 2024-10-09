return {
  "epwalsh/obsidian.nvim",
  version = "*",
  lazy = true,
  event = {
    "BufReadPre /home/raru/Obsidian Vault/**.md",
    "BufNewFile /home/raru/Obsidian Vault/**.md",
  },
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
  opts = {
    dir = "~/Obsidian Vault",
    log_level = vim.log.levels.INFO,

    completion = {
      nvim_cmp = true,
      min_chars = 1,
    },
    picker = {
      name = "telescope.nvim",
    },
    mappings = {},

    ui = {
      enable = false,
    },

    follow_url_func = function(url)
      vim.fn.jobstart { "xdg-open", url }
    end,
  },
  config = function(_, opts)
    local map = vim.keymap.set

    require("obsidian").setup(opts)

    map("n", "<leader>oo", "<cmd>ObsidianOpen<CR>", { desc = "obsidian open app" })
    map("n", "<leader>on", ":ObsidianNew ", { desc = "obsidian new file" })
    map("n", "<leader>ofl", "<cmd>ObsidianBacklinks<CR>", { desc = "obsidian backlinks" })
    map("n", "<leader>oft", ":ObsidianTags ", { desc = "obsidian find tags" })
    map("n", "<leader>dn", ":ObsidianToday ", { desc = "obsidian daily notes" })
    map("n", "<leader>ot", ":ObsidianTemplate ", { desc = "obsidian paste template" })
    map("n", "<leader>pi", ":ObsidianPasteImg ", { desc = "obsidian paste image from clipboard" })
    map("n", "<leader>tc", "<cmd>ObsidianTOC<CR>", { desc = "obsidian table of contents" })
    map("n", "gf", function()
      return require("obsidian").util.gf_passthrough()
    end, { desc = "obsidian goto file" })
    map("n", "<leader>cc", function()
      return require("obsidian").util.toggle_checkbox()
    end, { desc = "obsidian toggle checkbox" })
    map("n", "<leader>sa", function()
      return require("obsidian").util.smart_action()
    end, { desc = "obsidian smart action" })
  end,
}
