if #vim.v.argv <= 2 then
  -- open nvim tree
  vim.cmd "NvimTreeFocus"
end

vim.api.nvim_create_autocmd("TextYankPost", {
  group = vim.api.nvim_create_augroup("highlight_yank", {}),
  desc = "Hightlight selection on yank",
  pattern = "*",
  callback = function()
    vim.highlight.on_yank { higroup = "Visual", timeout = 150 }
  end,
})
