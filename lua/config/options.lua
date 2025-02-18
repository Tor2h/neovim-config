local global = vim.g
local o = vim.opt

o.number = true
o.relativenumber = true
o.numberwidth = 4
o.showmode = false
-- o.showcmd = false
o.conceallevel = 2
o.concealcursor = "nc"

o.inccommand = "split"
o.smartcase = true
o.ignorecase = true

o.expandtab = true
o.tabstop = 2
o.softtabstop = 2
o.shiftwidth = 2
o.smartindent = true

o.termguicolors = true

o.laststatus = 3
o.ruler = false
o.history = 100
o.smoothscroll = true
o.ttyfast = true

o.scrolloff = 90
o.signcolumn = "yes"
o.isfname:append("@-@")

o.updatetime = 50
vim.diagnostic.config({ signs = false })

--global.skip_ts_context_commentstring_module = true
vim.cmd([[syntax on]])
vim.cmd([[filetype plugin indent on]])
