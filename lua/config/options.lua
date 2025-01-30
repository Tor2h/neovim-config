local global = vim.g
local o = vim.opt

o.number = true
o.relativenumber = true

o.expandtab = true
o.tabstop = 2
o.softtabstop = 2
o.shiftwidth = 2
o.smartindent = true

o.termguicolors = true

o.scrolloff = 90
o.signcolumn = "yes"
o.isfname:append("@-@")

o.updatetime = 50

global.skip_ts_context_commentstring_module = true
vim.cmd [[syntax on]]
vim.cmd [[filetype plugin indent on]]
