require "nvchad.mappings"

-- add yours here

local set = vim.keymap.set
local unset = vim.keymap.del

unset("n", "<C-n>")
unset("n", "<C-C>")
unset("n", "<leader>h")
unset("n", "<leader>v")

set("n", "J", "mzJ`z")

set("n", "|", "<cmd>vsplit<cr>", { desc = "split vertical" })
set("n", "\\", "<cmd>split<cr>", { desc = "split horizontal" })
set("n", ";", ":", { desc = "CMD enter command mode" })

set("n", "<C-a>", "ggVG", { desc = "file select all" })
set("n", "<C-q>", "<cmd>confirm qall<cr>", { desc = "quit all" })

set("n", "<C-h>", require("nvim-tmux-navigation").NvimTmuxNavigateLeft)
set("n", "<C-j>", require("nvim-tmux-navigation").NvimTmuxNavigateDown)
set("n", "<C-k>", require("nvim-tmux-navigation").NvimTmuxNavigateUp)
set("n", "<C-l>", require("nvim-tmux-navigation").NvimTmuxNavigateRight)
set("n", "<C-\\>", require("nvim-tmux-navigation").NvimTmuxNavigateLastActive)

set("n", "<leader>e", "<cmd>NvimTreeToggle<CR>", { desc = "toggle NvimTree window" })
set("n", "<leader>rs", ":%s/<C-r><C-w>/<C-r><C-w>/gI<Left><Left><Left>", { desc = "replace current selectionn" })
set("n", "<leader>q", "<cmd>confirm q<cr>", { desc = "quit" })

set("n", "<leader>fd", function()
  require("telescope.builtin").diagnostics()
end, { desc = "telescope find diagnostics" })

set("n", "<leader>ts", function()
  require("auto-save").toggle()
end, { desc = "toggle auto save" })
set("n", "<leader>U", vim.cmd.UndotreeToggle, { desc = "toggle undo tree" })
set("n", "<leader>T", vim.cmd.TodoTelescope, { desc = "telescope todos " })
set("n", "<leader>tw", function()
  vim.o.wrap = not vim.o.wrap
end, { desc = "toggle wrap" })

set("i", "jk", "<ESC>")
set("i", "<C-s>", "<cmd>w<cr>", { desc = "file save" })

set("v", "<S-Tab>", "<gv", { desc = "line unindent" })
set("v", "<Tab>", ">gv", { desc = "line indent" })
set("v", "J", ":m'>+1<CR>gv=gv")
set("v", "K", ":m-2<CR>gv=gv")

-- shared
set({ "n", "v" }, "<leader>p", '"_dP')

set({ "n", "v" }, "n", "nzzzv")
set({ "n", "v" }, "N", "Nzzzv")
set({ "n", "v" }, "<C-d>", "<C-d>zz")
set({ "n", "v" }, "<C-u>", "<C-u>zz")
set({ "n", "v" }, "G", "Gzz")
