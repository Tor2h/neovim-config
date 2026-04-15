local lazy_filetypes = { 'css', 'scss', 'sass', 'html', 'htmlangular', 'javascript', 'javascriptreact', 'typescript', 'typescriptreact', 'vue', 'svelte' }

local ensure_highlight_colors_loaded

ensure_highlight_colors_loaded = function()
  vim.pack.add({ 'https://github.com/brenoprata10/nvim-highlight-colors' })
  require("nvim-highlight-colors").setup()

  ensure_highlight_colors_loaded = function() end
end

vim.api.nvim_create_autocmd('FileType', {
  group = vim.api.nvim_create_augroup('plugins.highlight-colors.lazy', { clear = true }),
  pattern = lazy_filetypes,
  once = true,
  callback = ensure_highlight_colors_loaded,
})

if vim.tbl_contains(lazy_filetypes, vim.bo.filetype) then
  ensure_highlight_colors_loaded()
end
