local ensure_undotree_loaded

ensure_undotree_loaded = function()
  vim.pack.add({ 'https://github.com/jiaoshijie/undotree' })
  require("undotree").setup()

  ensure_undotree_loaded = function() end
end

vim.keymap.set('n', '<leader>ut', function()
  ensure_undotree_loaded()
  require('undotree').toggle()
end, { desc = "undotree", noremap = true, silent = true })
