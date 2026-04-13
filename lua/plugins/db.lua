local loaded = false

local function ensure_db_loaded()
  if loaded then
    return
  end

  loaded = true
  vim.pack.add({ 'https://github.com/tpope/vim-dadbod' })
  vim.pack.add({ 'https://github.com/kristijanhusak/vim-dadbod-completion' })
  vim.pack.add({ 'https://github.com/kristijanhusak/vim-dadbod-ui' })
  vim.pack.add({ 'https://github.com/Kurren123/mssql.nvim' })

  require('mssql').setup({
    keymap_prefix = "<leader>æ",
    max_row = 1000,
  })
end

vim.api.nvim_create_autocmd('FileType', {
  group = vim.api.nvim_create_augroup('plugins.db.lazy', { clear = true }),
  pattern = { 'sql' },
  callback = ensure_db_loaded,
})
