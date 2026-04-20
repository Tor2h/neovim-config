vim.pack.add({ 'https://github.com/folke/which-key.nvim' })

vim.keymap.set('n', '<leader>?', function()
  vim.cmd('WhichKey')
end, { desc = "WhichKey", noremap = true, silent = true })
