vim.pack.add({ 'https://github.com/tpope/vim-dadbod' })
vim.pack.add({ 'https://github.com/kristijanhusak/vim-dadbod-completion' })
vim.pack.add({ 'https://github.com/kristijanhusak/vim-dadbod-ui' })
vim.pack.add({ 'https://github.com/Kurren123/mssql.nvim' })

require('mssql').setup({
  keymap_prefix = "<leader>æ",
  max_row = 1000,
})
