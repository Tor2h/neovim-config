vim.pack.add({ 'https://github.com/folke/trouble.nvim' })


require("trouble").setup({})
vim.keymap.set('n', '<leader>o', function()
  vim.cmd('Trouble diagnostics toggle')
end, { desc = "Diagnostics (Trouble)", noremap = true, silent = true })
