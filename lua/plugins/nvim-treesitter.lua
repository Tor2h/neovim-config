vim.pack.add({
  {
    src = "https://github.com/nvim-treesitter/nvim-treesitter",
    version = "main",
  },
})

-- Fix Windows EPERM temp rename issue
vim.g.treesitter_install_dir = vim.fn.stdpath('data') .. '/treesitter'

require('nvim-treesitter').setup({})

-- Enable highlighting and indentation per filetype
vim.api.nvim_create_autocmd('FileType', {
  callback = function()
    pcall(vim.treesitter.start)
    vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
  end,
})

-- Install missing parsers
local ensureInstalled = {
  'angular',
  'c_sharp',
  'html',
  'javascript',
  'typescript',
  'tsx',
  'css',
  'rust',
  'typst',
}

local alreadyInstalled = require('nvim-treesitter.config').get_installed()
local parsersToInstall = vim.iter(ensureInstalled)
    :filter(function(parser)
      return not vim.tbl_contains(alreadyInstalled, parser)
    end)
    :totable()

if #parsersToInstall > 0 then
  require('nvim-treesitter').install(parsersToInstall)
end

-- Handle nvim-treesitter updates
vim.api.nvim_create_autocmd('PackChanged', {
  desc = 'Handle nvim-treesitter updates',
  group = vim.api.nvim_create_augroup('nvim-treesitter-pack-changed-update-handler', { clear = true }),
  callback = function(event)
    if event.data.kind == 'update' and event.data.spec.name == 'nvim-treesitter' then
      vim.notify('nvim-treesitter updated, running TSUpdate...', vim.log.levels.INFO)
      local ok = pcall(vim.cmd, 'TSUpdate')
      if ok then
        vim.notify('TSUpdate completed successfully!', vim.log.levels.INFO)
      else
        vim.notify('TSUpdate command not available yet, skipping', vim.log.levels.WARN)
      end
    end
  end,
})
