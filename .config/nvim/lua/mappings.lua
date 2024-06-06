require "nvchad.mappings"

local map = vim.keymap.set
local nomap = vim.keymap.del

-- normal
nomap("n", "<C-n>")
nomap("n", "<leader>h")
nomap("n", "<leader>v")

map("n", "<Up>", function() vim.notify("No arrow keys for you!", vim.log.levels.WARN) end, { desc = "Disabled" })
map("n", "<Down>", function() vim.notify("No arrow keys for you!", vim.log.levels.WARN) end, { desc = "Disabled" })
map("n", "<Left>", function() vim.notify("No arrow keys for you!", vim.log.levels.WARN) end, { desc = "Disabled" })
map("n", "<Right>", function() vim.notify("No arrow keys for you!", vim.log.levels.WARN) end, { desc = "Disabled" })

map("n", "J", "mzJ`z")

map("n", "|", "<cmd>vsplit<cr>", { desc = "Vertical Split" })
map("n", "\\", "<cmd>split<cr>", { desc = "Horizontal Split" })
map("n", ";", ":", { desc = "CMD enter command mode" })

map("n", "<C-q>", "<cmd>confirm qall<cr>", { desc = "Quit all" })

map('n', "<C-h>", require('nvim-tmux-navigation').NvimTmuxNavigateLeft, { desc = "mata" })
map('n', "<C-j>", require('nvim-tmux-navigation').NvimTmuxNavigateDown)
map('n', "<C-k>", require('nvim-tmux-navigation').NvimTmuxNavigateUp)
map('n', "<C-l>", require('nvim-tmux-navigation').NvimTmuxNavigateRight)
map('n', "<C-\\>", require('nvim-tmux-navigation').NvimTmuxNavigateLastActive)

map("n", "<leader>e", "<cmd>NvimTreeToggle<CR>", { desc = "Nvimtree Toggle window" })
map("n", "<leader>s", ":%s/<C-r><C-w>/<C-r><C-w>/gI<Left><Left><Left>", { desc = "Replace current selectionn" })
map("n", "<leader>q", "<cmd>confirm q<cr>", { desc = "Quit" })

map("n", "<leader>fd", function() require("telescope.builtin").diagnostics() end, { desc = "Lsp find diagnostics" })

map("n", "<leader>ts", function() require("auto-save").toggle() end, { desc = "Toggle AutoSave" })
map("n", "<leader>U", vim.cmd.UndotreeToggle, { desc = "Open UndoTree" })
map("n", "<leader>T", vim.cmd.TodoTelescope, { desc = "Open TODOs" })
map(
    "n",
    "<leader>tw",
    function()
        vim.opt.wrap = not vim.opt.wrap
        vim.notify("Toggled line wrap", vim.log.levels.INFO)
    end,
    { desc = "Toggle Wrap" }
)

-- input
map("i", "jk", "<ESC>")
map("i", "<C-s>", ":w<cr>", { desc = "Save File" })

-- visual
map("v", "<S-Tab>", "<gv", { desc = "Unindent line" })
map("v", "<Tab>", ">gv", { desc = "Indent line" })
map("v", "J", ":m'>+1<CR>gv=gv")
map("v", "K", ":m-2<CR>gv=gv")
map("v", "<Up>", function() vim.notify("No arrow keys for you!", vim.log.levels.WARN) end, { desc = "Disabled" })
map("v", "<Down>", function() vim.notify("No arrow keys for you!", vim.log.levels.WARN) end, { desc = "Disabled" })
map("v", "<Left>", function() vim.notify("No arrow keys for you!", vim.log.levels.WARN) end, { desc = "Disabled" })
map("v", "<Right>", function() vim.notify("No arrow keys for you!", vim.log.levels.WARN) end, { desc = "Disabled" })


-- shared
map({ "n", "x" }, "<leader>p", '"_dP')

map({ "n", "v" }, "n", "nzzzv")
map({ "n", "v" }, "N", "Nzzzv")
map({ "n", "v" }, "<C-d>", "<C-d>zz")
map({ "n", "v" }, "<C-u>", "<C-u>zz")
map({ "n", "v" }, "G", "Gzz")
