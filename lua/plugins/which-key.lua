local ensure_which_key_loaded

ensure_which_key_loaded = function()
  vim.pack.add({ 'https://github.com/folke/which-key.nvim' })

  ensure_which_key_loaded = function() end
end

vim.keymap.set('n', '<leader>?', function()
  ensure_which_key_loaded()
  vim.cmd('WhichKey')
end, { desc = "WhichKey", noremap = true, silent = true })
