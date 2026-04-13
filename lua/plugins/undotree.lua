local loaded = false

local function ensure_undotree_loaded()
  if loaded then
    return
  end

  loaded = true
  vim.pack.add({ 'https://github.com/jiaoshijie/undotree' })
  require("undotree").setup()
end

vim.keymap.set('n', '<leader>ut', function()
  ensure_undotree_loaded()
  require('undotree').toggle()
end, { desc = "undotree", noremap = true, silent = true })
