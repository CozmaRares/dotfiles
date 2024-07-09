require "nvchad.mappings"

local nvim = vim
local map = nvim.keymap.set
local nomap = nvim.keymap.del

-- normal
nomap("n", "<C-n>")
nomap("n", "<leader>h")
nomap("n", "<leader>v")

map("n", "J", "mzJ`z")

map("n", "|", "<cmd>vsplit<cr>", { desc = "split vertical" })
map("n", "\\", "<cmd>split<cr>", { desc = "split horizontal" })
map("n", ";", ":", { desc = "CMD enter command mode" })

map("n", "<C-q>", "<cmd>confirm qall<cr>", { desc = "quit all" })

map("n", "<C-h>", require("nvim-tmux-navigation").NvimTmuxNavigateLeft)
map("n", "<C-j>", require("nvim-tmux-navigation").NvimTmuxNavigateDown)
map("n", "<C-k>", require("nvim-tmux-navigation").NvimTmuxNavigateUp)
map("n", "<C-l>", require("nvim-tmux-navigation").NvimTmuxNavigateRight)
map("n", "<C-\\>", require("nvim-tmux-navigation").NvimTmuxNavigateLastActive)

map("n", "<leader>e", "<cmd>NvimTreeToggle<CR>", { desc = "toggle NvimTree window" })
map("n", "<leader>rs", ":%s/<C-r><C-w>/<C-r><C-w>/gI<Left><Left><Left>", { desc = "replace current selectionn" })
map("n", "<leader>q", "<cmd>confirm q<cr>", { desc = "quit" })

map("n", "<leader>fd", function()
  require("telescope.builtin").diagnostics()
end, { desc = "telescope find diagnostics" })

map("n", "<leader>ts", function()
  require("auto-save").toggle()
end, { desc = "toggle auto save" })
map("n", "<leader>U", nvim.cmd.UndotreeToggle, { desc = "toggle undo tree" })
map("n", "<leader>T", nvim.cmd.TodoTelescope, { desc = "telescope todos " })
map("n", "<leader>tw", function()
  nvim.opt.wrap = not nvim.opt.wrap
  nvim.notify("toggled line wrap", { title = "NVIM API" }, nvim.log.levels.INFO)
end, { desc = "toggle wrap" })

-- input
map("i", "jk", "<ESC>")
map("i", "<C-s>", ":w<cr>", { desc = "save file" })

-- visual
map("v", "<S-Tab>", "<gv", { desc = "line unindent" })
map("v", "<Tab>", ">gv", { desc = "line indent" })
map("v", "J", ":m'>+1<CR>gv=gv")
map("v", "K", ":m-2<CR>gv=gv")

-- shared
map({ "n", "v" }, "<leader>p", '"_dP')

map({ "n", "v" }, "n", "nzzzv")
map({ "n", "v" }, "N", "Nzzzv")
map({ "n", "v" }, "<C-d>", "<C-d>zz")
map({ "n", "v" }, "<C-u>", "<C-u>zz")
map({ "n", "v" }, "G", "Gzz")

map({ "n", "v" }, "<Up>", function()
  nvim.notify("No arrow keys for you!", nvim.log.levels.WARN)
end, { desc = "disabled" })
map({ "n", "v" }, "<Down>", function()
  nvim.notify("No arrow keys for you!", nvim.log.levels.WARN)
end, { desc = "disabled" })
map({ "n", "v" }, "<Left>", function()
  nvim.notify("No arrow keys for you!", nvim.log.levels.WARN)
end, { desc = "disabled" })
map({ "n", "v" }, "<Right>", function()
  nvim.notify("No arrow keys for you!", nvim.log.levels.WARN)
end, { desc = "disabled" })
