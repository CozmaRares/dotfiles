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

    daily_notes = {
      folder = "notes/daily",
      date_format = "%Y-%m-%d",
      alias_format = "%B %-d, %Y",
      default_tags = { "daily" },
      template = "daily.md",
    },

    completion = {
      nvim_cmp = true,
      min_chars = 1,
    },
    templates = {
      folder = "templates",
      date_format = "%Y-%m-%d",
      time_format = "%H:%M",
      substitutions = {},
    },
    picker = {
      name = "telescope.nvim",
    },
    mappings = {},

    ui = {
      enable = true,
      update_debounce = 200,
      max_file_length = 5000,
      checkboxes = {
        [" "] = { char = "", hl_group = "ObsidianTodo" },
        ["x"] = { char = "", hl_group = "ObsidianDone" },
        [">"] = { char = "", hl_group = "ObsidianRightArrow" },
        ["~"] = { char = "󰰱", hl_group = "ObsidianTilde" },
        ["!"] = { char = "", hl_group = "ObsidianImportant" },
      },
      bullets = { char = "•", hl_group = "ObsidianBullet" },
      external_link_icon = { char = "", hl_group = "ObsidianExtLinkIcon" },
      reference_text = { hl_group = "ObsidianRefText" },
      highlight_text = { hl_group = "ObsidianHighlightText" },
      tags = { hl_group = "ObsidianTag" },
      block_ids = { hl_group = "ObsidianBlockID" },
      hl_groups = {
        ObsidianTodo = { bold = true, fg = "#f78c6c" },
        ObsidianDone = { bold = true, fg = "#89ddff" },
        ObsidianRightArrow = { bold = true, fg = "#f78c6c" },
        ObsidianTilde = { bold = true, fg = "#ff5370" },
        ObsidianImportant = { bold = true, fg = "#d73128" },
        ObsidianBullet = { bold = true, fg = "#89ddff" },
        ObsidianRefText = { underline = true, fg = "#c792ea" },
        ObsidianExtLinkIcon = { fg = "#c792ea" },
        ObsidianTag = { italic = true, fg = "#89ddff" },
        ObsidianBlockID = { italic = true, fg = "#89ddff" },
        ObsidianHighlightText = { bg = "#75662e" },
      },
    },
    follow_url_func = function(url)
      vim.fn.jobstart { "xdg-open", url }
    end,
  },
  config = function(_, opts)
    local map = vim.keymap.set

    require("obsidian").setup(opts)
    vim.o.conceallevel = 1

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
