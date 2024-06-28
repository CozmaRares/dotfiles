-- Set up custom filetypes
-- vim.filetype.add {
--   extension = {
--     foo = "fooscript",
--   },
--   filename = {
--     ["Foofile"] = "fooscript",
--   },
--   pattern = {
--     ["~/%.config/foo/.*"] = "fooscript",
--   },
-- }

local map = vim.keymap.set

map("n", "<C-h>", require("nvim-tmux-navigation").NvimTmuxNavigateLeft)
map("n", "<C-j>", require("nvim-tmux-navigation").NvimTmuxNavigateDown)
map("n", "<C-k>", require("nvim-tmux-navigation").NvimTmuxNavigateUp)
map("n", "<C-l>", require("nvim-tmux-navigation").NvimTmuxNavigateRight)
map("n", "<C-\\>", require("nvim-tmux-navigation").NvimTmuxNavigateLastActive)
