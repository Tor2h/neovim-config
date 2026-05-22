local function to_string_or_nil(value)
  if value == nil or value == vim.NIL then
    return nil
  end
  if type(value) == "string" then
    return value
  end
  return tostring(value)
end

local function set_completion_highlights()
  vim.api.nvim_set_hl(0, "BlinkCmpMenu", { link = "Normal" })
  vim.api.nvim_set_hl(0, "BlinkCmpMenuBorder", { link = "Normal" })
  vim.api.nvim_set_hl(0, "BlinkCmpMenuSelection", { link = "PmenuSel" })
  vim.api.nvim_set_hl(0, "BlinkCmpDoc", { link = "Normal" })
  vim.api.nvim_set_hl(0, "BlinkCmpDocBorder", { link = "Normal" })
  vim.api.nvim_set_hl(0, "BlinkCmpSignatureHelp", { link = "Normal" })
  vim.api.nvim_set_hl(0, "BlinkCmpSignatureHelpBorder", { link = "Normal" })
end

local ensure_completion_loaded
local load_svelte_snippets

ensure_completion_loaded = function()
  vim.pack.add({ 'https://github.com/rafamadriz/friendly-snippets' })
  vim.pack.add({ 'https://github.com/L3MON4D3/LuaSnip' })
  vim.pack.add({
    {
      src = 'https://github.com/Saghen/blink.cmp',
      version = 'v1',
    },
  })

  local luasnip = require("luasnip")
  luasnip.filetype_extend("htmlangular", { "html" })
  require("luasnip.loaders.from_vscode").lazy_load()

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
      transform_items = function(_, items)
        for _, item in ipairs(items) do
          item.label = to_string_or_nil(item.label) or ""
          item.filterText = to_string_or_nil(item.filterText)
          item.insertText = to_string_or_nil(item.insertText)
          item.sortText = to_string_or_nil(item.sortText)

          if type(item.labelDetails) == "table" then
            item.labelDetails.description = to_string_or_nil(item.labelDetails.description)
          end

          if type(item.documentation) ~= "table" then
            item.documentation = to_string_or_nil(item.documentation)
          end
        end
        return items
      end,
    },
    cmdline = {
      sources = { 'cmdline' },
    },
    completion = {
      menu = {
        draw = {
          -- treesitter = { "lsp" },
        },
      },
      documentation = { auto_show = false, window = { border = "rounded" } },
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

  ensure_completion_loaded = function() end
end

load_svelte_snippets = function()
  ensure_completion_loaded()

  vim.pack.add({ 'https://github.com/nvim-svelte/nvim-svelte-snippets' })
  require("nvim-svelte-snippets").setup({
    enabled = true,
    auto_detect = true,
    prefix = "kit",
  })

  load_svelte_snippets = function() end
end

vim.api.nvim_create_autocmd("FileType", {
  pattern = "svelte",
  callback = load_svelte_snippets,
})

vim.api.nvim_create_autocmd("ColorScheme", {
  group = vim.api.nvim_create_augroup("plugins.completion.highlights", { clear = true }),
  callback = set_completion_highlights,
})

set_completion_highlights()

vim.api.nvim_create_autocmd({ "InsertEnter", "CmdlineEnter" }, {
  group = vim.api.nvim_create_augroup("plugins.completion.lazy", { clear = true }),
  once = true,
  callback = ensure_completion_loaded,
})
