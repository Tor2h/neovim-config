require('plugins.auto-session')
require('config.autocmd')
require('config.globals')
require('config.keymap')
require('config.lsp')
require('plugins.which-key')
require('plugins.roslyn')
local lazyload = require('lazyload')

require('plugins.kanagawa')
require('plugins.themes')
require('config.options')

lazyload.require_modules_on_vim_enter({
  'plugins.lualine',
  'plugins.mini',
  'plugins.yanky',
}, { sync = true })

lazyload.require_modules_on_vim_enter({
  'plugins.telescope',
  'plugins.nvim-treesitter',
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
