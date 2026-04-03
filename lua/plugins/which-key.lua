vim.pack.add({ 'https://github.com/folke/which-key.nvim' })

vim.api.nvim_set_keymap('n', '<leader>?', '<cmd>WhichKey<CR>', { desc = "WhichKey", noremap = true, silent = true })
