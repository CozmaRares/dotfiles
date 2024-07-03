local linters = {
  by_ft = {
    markdown = { "markdownlint" },
  },
  by_linter = {
    cpplint = { "c", "cpp" },
    eslint_d = {
      "astro",
      "html",
      "javascriptreact",
      "svelte",
      "typescriptreact",
      "vue",
    },
  },
}

local opts = linters.by_ft

for linter, fts in pairs(linters.by_linter) do
  for _, ft in ipairs(fts) do
    opts[ft] = { linter }
  end
end

require("lint").linters_by_ft = opts

vim.keymap.set("n", "<leader>l", function()
  require("lint").try_lint()
end, { desc = "lint file" })
