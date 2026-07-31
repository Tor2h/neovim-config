local pending_callbacks = {}
local mssql

local function configure_mssql()
  mssql.setup({
    connections_file = vim.fs.joinpath(vim.fn.stdpath('data'), 'mssql.nvim', 'connections.json'),
    keymap_prefix = '<leader>æ',
    max_rows = 1000,
  }, function()
    local callbacks = pending_callbacks
    pending_callbacks = {}

    for _, queued_callback in ipairs(callbacks) do
      queued_callback(mssql)
    end
  end)
end

vim.pack.add({ 'https://github.com/tpope/vim-dadbod' })
vim.pack.add({ 'https://github.com/kristijanhusak/vim-dadbod-completion' })
vim.pack.add({ 'https://github.com/kristijanhusak/vim-dadbod-ui' })
vim.pack.add({ 'https://github.com/Kurren123/mssql.nvim' })

mssql = require('mssql')
configure_mssql()
