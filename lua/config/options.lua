local global = vim.g
local o = vim.opt

global.snacks_animate = false

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

o.scrolloff = 10
o.signcolumn = "yes"
o.isfname:append("@-@")
o.fillchars = { eob = " " }
o.guifont = "Iosevka Nerd Font:h17"
global.neovide_title_background_color = "black"
global.neovide_hide_mouse_when_typing = true
global.neovide_refresh_rate = 60

global.python_host_skip_check = 1
global.python3_host_skip_check = 1

o.updatetime = 50
--vim.diagnostic.config({ signs = false })
vim.diagnostic.config({
	-- virtual_text = false, -- Disable inline text if it clutters the UI
	float = {
		source = "if_many", -- Show the source of diagnostics only if there are multiple
	},
})

--global.skip_ts_context_commentstring_module = true
vim.cmd([[syntax on]])
vim.cmd([[filetype plugin indent on]])
