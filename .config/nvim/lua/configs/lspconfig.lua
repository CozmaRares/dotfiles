local on_attach = require("nvchad.configs.lspconfig").on_attach
local on_init = require("nvchad.configs.lspconfig").on_init
local capabilities = require("nvchad.configs.lspconfig").capabilities
capabilities.textDocument.completion.completionItem.snippetSupport = true

local lspconfig = require "lspconfig"
local root_pattern = lspconfig.util.root_pattern

local servers = {
  clangd = {
    filetypes = { "c", "cpp" },
    root_dir = root_pattern(".clang-format", ".git"),
  },

  emmet_ls = {
    filetypes = {
      "astro",
      "html",
      "javascriptreact",
      "svelte",
      "typescriptreact",
      "vue",
      "php",
    },
  },

  rust_analyzer = {
    filetypes = { "rust" },
    root_dir = root_pattern "Cargo.toml",
  },

  tailwindcss = {
    filetypes = {
      "astro",
      "astro-markdown",
      "html",
      "mdx",
      "css",
      "less",
      "postcss",
      "sass",
      "scss",
      "javascriptreact",
      "typescriptreact",
      "vue",
      "svelte",
    },
    root_dir = root_pattern("tailwind.config.js", "tailwind.config.cjs", "tailwind.config.mjs", "tailwind.config.ts"),
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
          recommendedVariantOrder = "warning",
        },
        validate = true,
      },
    },
  },

  intelephense = {
    filetypes = { "php" },
    root_dir = root_pattern("composer.json", ".git"),
    settings = {
      intelephense = {
        format = {
          braces = "k&r",
        },
      },
    },
  },

  tsserver = {
    init_options = {
      preferences = {
        disableSuggestions = true,
      },
    },
  },

  -- LSPs with default settings
  cssls = {},
  html = {},
  lua_ls = {},
}

local defaults = {
  on_attach = on_attach,
  on_init = on_init,
  capabilities = capabilities,
}

-- lsps with default config
for server, opts in pairs(servers) do
  local merged_opts = vim.tbl_deep_extend("force", defaults, opts)
  lspconfig[server].setup(merged_opts)
end
