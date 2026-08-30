require('config.data_path').setup()

require('plugins.auto-session')
require('config.autocmd')
require('config.globals')
require('config.keymap')
require('config.lsp')
require('plugins.which-key')
require('plugins.roslyn')
require('plugins.kanagawa')
require('plugins.nvim-treesitter')
require('plugins.telescope')
require('plugins.oil')
require('config.options')
require('plugins.auto-tag')

require('plugins.lualine')
require('plugins.mini')
require('plugins.yanky')
require('plugins.db')
require('plugins.gitsigns')
require('plugins.global-note')
require('plugins.harpoon')
require('plugins.highlight-colors')
require('plugins.render-markdown')
-- require('plugins.none-ls')
require('plugins.completion')
require('plugins.undotree')
require('plugins.trouble')
require('plugins.typst')
require('plugins.dap')
require('plugins.netrw')


-- lazyload.require_modules_on_vim_enter({
--   'plugins.lualine',
--   'plugins.mini',
--   'plugins.yanky',
-- }, { sync = true })
--
-- lazyload.require_modules_on_vim_enter({
--   'plugins.db',
--   'plugins.gitsigns',
--   'plugins.global-note',
--   'plugins.harpoon',
--   'plugins.highlight-colors',
--   'plugins.render-markdown',
--   'plugins.none-ls',
--   'plugins.completion',
--   'plugins.undotree',
-- })
