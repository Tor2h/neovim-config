require('plugins.auto-session')
require('config.autocmd')
require('config.globals')
require('config.keymap')
require('config.lsp')
local lazyload = require('lazyload')

require('plugins.kanagawa')
require('config.options')

lazyload.require_modules_on_vim_enter({
  'plugins.lualine',
  'plugins.mini',
  'plugins.yanky',
}, { sync = true })

lazyload.require_modules_on_vim_enter({
  'plugins.which-key',
  'plugins.telescope',
  'plugins.nvim-treesitter',
  'plugins.roslyn',
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
  'plugins.oil',
})
