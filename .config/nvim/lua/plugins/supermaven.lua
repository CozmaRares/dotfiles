return {
  "supermaven-inc/supermaven-nvim",
  event = "InsertEnter",
  opts = {
    -- keymaps = {
    --   accept_suggestion = "<Tab>",
    --   clear_suggestion = "<C-]>",
    --   accept_word = "<C-j>",
    -- },
    -- ignore_filetypes = { cpp = true }, -- or { "cpp", }
    color = {
      suggestion_color = "#ffffff",
      cterm = 244,
    },
    log_level = "info",
    disable_inline_completion = true,
    disable_keymaps = true,
  },
}
