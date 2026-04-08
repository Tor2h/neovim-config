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
    ['<Tab>'] = {
      function(cmp)
        if cmp.is_visible() then
          return cmp.select_next({ auto_insert = true })
        end
        return cmp.show({ initial_selected_item_idx = 1 })
      end,
      'snippet_forward',
      'fallback',
    },
    ['<S-Tab>'] = {
      function(cmp)
        if cmp.is_visible() then
          return cmp.select_prev({ auto_insert = true })
        end
        return cmp.show({ initial_selected_item_idx = -1 })
      end,
      'snippet_backward',
      'fallback',
    },
    ['<CR>'] = {
      function(cmp)
        if cmp.is_visible() then
          return cmp.accept()
        end
      end,
      'fallback',
    }
  },
  snippets = {
    preset = 'luasnip',
  },
  sources = {
    default = { 'lsp', 'path', 'snippets', 'buffer' },
  },
  cmdline = {
    -- default = { 'lsp', 'path', 'snippets', 'buffer' },
    sources = { 'cmdline' },
  },
  completion = {
    menu = {
      draw = {
        treesitter = { "lsp" },
      },
    },
    documentation = { auto_show = true, window = { border = "rounded" } },
    list = {
      selection = {
        preselect = false,
        auto_insert = false,
      },
    },
  },
  appearance = {
    nerd_font_variant = "mono",
  },
  fuzzy = { implementation = "lua" }
})
