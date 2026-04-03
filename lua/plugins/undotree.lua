vim.pack.add({ 'https://github.com/jiaoshijie/undotree' })

require("undotree").setup()
vim.api.nvim_set_keymap('n', '<leader>ut', "<cmd>lua require('undotree').toggle()<CR>",
  { desc = "undotree", noremap = true, silent = true })
