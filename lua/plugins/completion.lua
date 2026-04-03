vim.pack.add({ 'https://github.com/rafamadriz/friendly-snippets' })
vim.pack.add({ 'https://github.com/L3MON4D3/LuaSnip' })
vim.pack.add({ 'https://github.com/nvim-svelte/nvim-svelte-snippets' })
vim.pack.add({ 'https://github.com/Saghen/blink.cmp' })

local luasnip = require("luasnip")
luasnip.filetype_extend("htmlangular", { "html" })
require("luasnip.loaders.from_vscode").lazy_load()
require("nvim-svelte-snippets").setup({
  enabled = true,
  auto_detect = true,
  prefix = "kit",
})

require("blink.cmp").setup({
  keymap = {
    preset = 'default',
  },
  snippets = {
    preset = 'luasnip',
  },
  cmdline = {
    -- default = { 'lsp', 'path', 'snippets', 'buffer' },
    sources = { 'cmdline' },
  },
  completion = {
    documentation = { auto_show = true },
  },
  fuzzy = { implementation = "lua" }
})
