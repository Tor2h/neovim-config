local global = vim.g
local o = vim.opt
local is_windows_terminal = vim.env.WT_SESSION ~= nil and vim.env.WT_SESSION ~= ""

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
o.tabstop = 4
o.softtabstop = 4
o.shiftwidth = 4
o.smartindent = true

o.termguicolors = true

o.laststatus = 3
o.ruler = false
o.history = 100
o.smoothscroll = not is_windows_terminal
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

o.winborder = "rounded"
o.updatetime = 50
o.sessionoptions = "blank,buffers,curdir,help,tabpages,winsize,winpos,terminal"
--vim.diagnostic.config({ signs = false })
---- Recommended settings for 0.11.6
vim.diagnostic.config({
  virtual_text = { prefix = "●" },
  underline = true,
  signs = false, -- Reduce clutter if using gutter signs elsewhere
  update_in_insert = false,
  float = {
    source = true, -- Show the source of diagnostics only if there are multiple
  },
})

o.swapfile = false
o.backup = false
o.undofile = false
require('vim._core.ui2').enable({
  enable = true, -- Whether to enable or disable the UI.
  msg = {        -- Options related to the message module.
    ---@type 'cmd'|'msg' Default message target, either in the
    ---cmdline or in a separate ephemeral message window.
    ---@type string|table<string, 'cmd'|'msg'|'pager'> Default message target
    ---or table mapping |ui-messages| kinds and triggers to a target.
    targets = 'msg',
    cmd = {           -- Options related to messages in the cmdline window.
      height = 0.5    -- Maximum height while expanded for messages beyond 'cmdheight'.
    },
    dialog = {        -- Options related to dialog window.
      height = 0.5,   -- Maximum height.
    },
    msg = {           -- Options related to msg window.
      height = 0.5,   -- Maximum height.
      timeout = 4000, -- Time a message is visible in the message window.
    },
    pager = {         -- Options related to message window.
      height = 1,     -- Maximum height.
    },
  },
})
