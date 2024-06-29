---@type LazySpec
return {
  "AstroNvim/astrocore",
  ---@type AstroCoreOpts
  opts = {
    -- Configure core features of AstroNvim
    features = {
      large_buf = { size = 1024 * 256, lines = 10000 }, -- set global limits for large files for disabling features like treesitter
      autopairs = true,
      cmp = true,
      diagnostics_mode = 3, -- diagnostic mode on start (0 = off, 1 = no signs/virtual text, 2 = no virtual text, 3 = on)
      highlighturl = true,
      notifications = true,
    },
    -- Diagnostics configuration (for vim.diagnostics.config({...})) when diagnostics are on
    diagnostics = {
      virtual_text = true,
      underline = true,
    },
    -- vim options can be configured here
    options = {
      opt = {
        -- vim.opt.<key>
        relativenumber = true,
        number = true,
        spell = false,
        signcolumn = "auto",
        wrap = false,
        guicursor = "",
        tabstop = 4,
        softtabstop = 4,
        expandtab = true,
        shiftwidth = 0,
        smartindent = true,
        hlsearch = false,
        incsearch = true,
        termguicolors = true,
        scrolloff = 8,
        updatetime = 50,
        swapfile = false,
        backup = false,
        undodir = os.getenv "HOME" .. "/.cache/nvim/undodir",
        undofile = true,
      },
      g = {
        -- vim.g.<key>
      },
    },
    mappings = {
      n = {
        ["<Leader>x"] = {
          function()
            local bufs = vim.fn.getbufinfo { buflisted = 1 }
            require("astrocore.buffer").close(0)
            if require("astrocore").is_available "alpha-nvim" and not bufs[2] then require("alpha").start() end
          end,
          desc = "Close buffer",
        },
        ["J"] = { "mzJ`z" },
        [";"] = { ":", desc = "Enter command mode" },
        ["<leader>s"] = { ":%s/<C-r><C-w>/<C-r><C-w>/gI<Left><Left><Left>", desc = "Replace current selectionn" },
        ["<leader>ms"] = { function() require("auto-save").toggle() end, desc = "Toggle AutoSave" },
        ["<leader>U"] = { vim.cmd.UndotreeToggle, desc = "Open UndoTree" },
        ["<leader>T"] = { vim.cmd.TodoTelescope, desc = "Open TODOs" },

        ["<leader>p"] = { '"_dP' },
        ["n"] = { "nzzzv" },
        ["N"] = { "Nzzzv" },
        ["<C-d>"] = { "<C-d>zz" },
        ["<C-u>"] = { "<C-u>zz" },
        ["G"] = { "Gzz" },

        -- navigate buffer tabs
        ["<Tab>"] = { function() require("astrocore.buffer").nav(vim.v.count1) end, desc = "Next buffer" },
        ["<S-Tab>"] = { function() require("astrocore.buffer").nav(-vim.v.count1) end, desc = "Previous buffer" },

        -- mappings seen under group name "Buffer"
        ["<Leader>bd"] = {
          function()
            require("astroui.status.heirline").buffer_picker(
              function(bufnr) require("astrocore.buffer").close(bufnr) end
            )
          end,
          desc = "Close buffer from tabline",
        },

        -- quit
        ["<C-q>"] ={ "<cmd>confirm qall<cr>", desc = "Quit vim" },
        ["<leader>q"] ={ "<cmd>confirm q<cr>", desc = "Quit window" },

        -- disable mappings
        ["<Leader>c"] = false,
        ["<Leader>C"] = false,
        ["<C-n>"] = false,
        ["<leader>h"] = false,
        ["<leader>v"] = false,
        ["<Up>"] = false,
        ["<Down>"] = false,
        ["<Left>"] = false,
        ["<Right>"] = false,

        -- define menus
        ["<Leader>m"] = { desc = "Miscellaneous" },
      },
      v = {
        ["J"] = { ":m'>+1<CR>gv=gv" },
        ["K"] = { ":m-2<CR>gv=gv" },

        ["<leader>p"] = { '"_dP' },
        ["n"] = { "nzzzv" },
        ["N"] = { "Nzzzv" },
        ["<C-d>"] = { "<C-d>zz" },
        ["<C-u>"] = { "<C-u>zz" },
        ["G"] = { "Gzz" },

        -- disable mappings
        ["<Leader>c"] = false,
        ["<Leader>C"] = false,
        ["<C-n>"] = false,
        ["<leader>h"] = false,
        ["<leader>v"] = false,
        ["<Up>"] = false,
        ["<Down>"] = false,
        ["<Left>"] = false,
        ["<Right>"] = false,
      },
    },
  },
}
