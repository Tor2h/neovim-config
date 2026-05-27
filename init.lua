require('config.data_path').setup()

require('plugins.auto-session')
require('config.autocmd')
require('config.globals')
require('config.keymap')
require('config.lsp')
require('plugins.which-key')
require('plugins.roslyn')
require('plugins.kanagawa')
require('plugins.telescope')
require('plugins.nvim-treesitter')
require('plugins.oil')
require('plugins.themes')
require('config.options')

local lazyload = require('lazyload')

lazyload.require_modules_on_vim_enter({
  'plugins.lualine',
  'plugins.mini',
  'plugins.yanky',
}, { sync = true })

lazyload.require_modules_on_vim_enter({
  'plugins.auto-tag',
  'plugins.db',
  'plugins.gitsigns',
  'plugins.global-note',
  'plugins.harpoon',
  'plugins.highlight-colors',
  'plugins.render-markdown',
  'plugins.none-ls',
  'plugins.completion',
  'plugins.undotree',
})
