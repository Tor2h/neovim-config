vim.pack.add({ 'https://github.com/jiaoshijie/undotree' })
require("undotree").setup()

vim.keymap.set('n', '<leader>ut', function()
  require('undotree').toggle()
end, { desc = "undotree", noremap = true, silent = true })
