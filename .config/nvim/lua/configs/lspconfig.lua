local on_attach = function(ign, bufnr)
  vim.keymap.set('n', '<leader>lf', function() vim.diagnostic.open_float() end, { desc = "lsp open diagnostic float" })
  vim.keymap.set('n', '<leader>lw', function() vim.diagnostic.goto_next() end, { desc = "lsp next diagnostic" })
  vim.keymap.set('n', '<leader>ls', function() vim.diagnostic.goto_prev() end, { desc = "lsp prev diagnostic" })
  require("nvchad.configs.lspconfig").on_attach(ign, bufnr)
end
local on_init = require("nvchad.configs.lspconfig").on_init
local capabilities = require("nvchad.configs.lspconfig").capabilities

local lspconfig = require "lspconfig"
local root_pattern = lspconfig.util.root_pattern

local servers = {
  clangd = {
    filetypes = { "c", "cpp" },
    root_dir = root_pattern( '.clang-format', '.git')
  },

  cssls = {},

  emmet_ls = {
    filetypes = {
      "astro", "html", "javascriptreact",
      "svelte", "typescriptreact", "vue",
      "php"
    }
  },

  html = {},

  lua_ls = {},

  rust_analyzer = {
    filetypes = { "rust" },
    root_dir = root_pattern("Cargo.toml"),
  },

  tailwindcss = {
    filetypes = {
      "astro", "astro-markdown", "blade", "html", "markdown",
      "mdx", "php", "css", "less", "postcss", "sass", "scss", "javascriptreact", "typescriptreact",
      "vue", "svelte", "templ"
    },
    root_dir = root_pattern('tailwind.config.js', 'tailwind.config.cjs', 'tailwind.config.mjs', 'tailwind.config.ts'),
    settings = {
      tailwindCSS = {
        classAttributes = { "class", "className", "class:list", "classList", "ngClass" },
        lint = {
          cssConflict = "warning",
          invalidApply = "error",
          invalidConfigPath = "error",
          invalidScreen = "error",
          invalidTailwindDirective = "error",
          invalidVariant = "error",
          recommendedVariantOrder = "warning"
        },
        validate = true
      }
    }
  },

  tsserver = {}
}

local defaults = {
    on_attach = on_attach,
    on_init = on_init,
    capabilities = capabilities,
}

-- lsps with default config
for server, opts in pairs(servers) do
  local merged_opts  = vim.tbl_deep_extend("force", defaults, opts)
  lspconfig[server].setup (merged_opts)
end
