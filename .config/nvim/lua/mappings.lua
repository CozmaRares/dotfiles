require "nvchad.mappings"

local map = vim.keymap.set
local nomap = vim.keymap.del

-- normal
nomap("n", "<C-n>")
nomap("n", "<C-C>")
nomap("n", "<leader>h")
nomap("n", "<leader>v")

map("n", "J", "mzJ`z")

map("n", "|", "<cmd>vsplit<cr>", { desc = "split vertical" })
map("n", "\\", "<cmd>split<cr>", { desc = "split horizontal" })
map("n", ";", ":", { desc = "CMD enter command mode" })

map("n", "<C-a>", "ggVG", { desc = "file select all" })
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
map("n", "<leader>U", vim.cmd.UndotreeToggle, { desc = "toggle undo tree" })
map("n", "<leader>T", vim.cmd.TodoTelescope, { desc = "telescope todos " })
map("n", "<leader>tw", function()
  vim.o.wrap = not vim.o.wrap
end, { desc = "toggle wrap" })

map("n", "<leader>l", function()
  require("lint").try_lint()
end, { desc = "file lint" })

-- input
map("i", "jk", "<ESC>")
map("i", "<C-s>", ":w<cr>", { desc = "file save" })

-- visual
map("v", "<S-Tab>", "<gv", { desc = "line unindent" })
map("v", "<Tab>", ">gv", { desc = "line indent" })
map("v", "J", ":m'>+1<CR>gv=gv")
map("v", "K", ":m-2<CR>gv=gv")
map("v", "<leader>r", function()
  local patterns = {
    ["aa"] = "ă",
    ["ai"] = "â",
    ["ii"] = "î",
    ["ss"] = "ș",
    ["tt"] = "ț",
  }

  for match, replace in pairs(patterns) do
    pcall(vim.cmd, "s/\\%V" .. match .. "\\%V/" .. replace .. "/g")
  end
end, { desc = "replace patterns" })

-- shared
map({ "n", "v" }, "<leader>p", '"_dP')

map({ "n", "v" }, "n", "nzzzv")
map({ "n", "v" }, "N", "Nzzzv")
map({ "n", "v" }, "<C-d>", "<C-d>zz")
map({ "n", "v" }, "<C-u>", "<C-u>zz")
map({ "n", "v" }, "G", "Gzz")

map({ "n", "v" }, "<Up>", function()
  vim.notify("No arrow keys for you!", vim.log.levels.WARN)
end, { desc = "disabled" })
map({ "n", "v" }, "<Down>", function()
  vim.notify("No arrow keys for you!", vim.log.levels.WARN)
end, { desc = "disabled" })
map({ "n", "v" }, "<Left>", function()
  vim.notify("No arrow keys for you!", vim.log.levels.WARN)
end, { desc = "disabled" })
map({ "n", "v" }, "<Right>", function()
  vim.notify("No arrow keys for you!", vim.log.levels.WARN)
end, { desc = "disabled" })
