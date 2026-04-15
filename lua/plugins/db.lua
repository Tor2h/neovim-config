local ready = false
local pending_callbacks = {}
local mssql

local function configure_mssql()
  mssql.setup({
    connections_file = vim.fs.joinpath(vim.fn.stdpath('data'), 'mssql.nvim', 'connections.json'),
    keymap_prefix = '<leader>æ',
    max_rows = 1000,
  }, function()
    ready = true
    local callbacks = pending_callbacks
    pending_callbacks = {}

    for _, queued_callback in ipairs(callbacks) do
      queued_callback(mssql)
    end
  end)
end

local ensure_db_loaded

ensure_db_loaded = function(callback)
  if callback then
    table.insert(pending_callbacks, callback)
  end

  vim.pack.add({ 'https://github.com/tpope/vim-dadbod' })
  vim.pack.add({ 'https://github.com/kristijanhusak/vim-dadbod-completion' })
  vim.pack.add({ 'https://github.com/kristijanhusak/vim-dadbod-ui' })
  vim.pack.add({ 'https://github.com/Kurren123/mssql.nvim' })

  mssql = require('mssql')

  ensure_db_loaded = function(next_callback)
    if not next_callback then
      return
    end

    if ready then
      next_callback(mssql)
    else
      table.insert(pending_callbacks, next_callback)
    end
  end

  configure_mssql()
end

vim.api.nvim_create_autocmd('FileType', {
  group = vim.api.nvim_create_augroup('plugins.db.lazy', { clear = true }),
  pattern = { 'sql' },
  callback = function()
    ensure_db_loaded()
  end,
})

if vim.bo.filetype == 'sql' then
  ensure_db_loaded()
end

vim.api.nvim_create_user_command('MSSQLNewQuery', function()
  ensure_db_loaded(function(mssql)
    mssql.new_query()
  end)
end, { desc = 'Open a new MSSQL query buffer' })

vim.api.nvim_create_user_command('MSSQLDefaultQuery', function()
  ensure_db_loaded(function(mssql)
    mssql.new_default_query()
  end)
end, { desc = 'Open a new MSSQL query using the default connection' })

vim.api.nvim_create_user_command('MSSQLEditConnections', function()
  ensure_db_loaded(function(mssql)
    mssql.edit_connections()
  end)
end, { desc = 'Edit the MSSQL connections file' })
