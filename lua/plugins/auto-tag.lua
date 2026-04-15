local lazy_filetypes = { 'html', 'htmlangular', 'javascriptreact', 'typescriptreact', 'svelte', 'vue', 'xml' }

local ensure_auto_tag_loaded

ensure_auto_tag_loaded = function()
  vim.pack.add({ 'https://github.com/windwp/nvim-ts-autotag' })

  require('nvim-ts-autotag').setup({
    opts = {
      enable_close = true,
      enable_rename = true,
      enable_close_on_slash = false,
    },
    per_filetype = {
      ["html"] = {
        enable_close = true,
      },
    },
  })

  ensure_auto_tag_loaded = function() end
end

vim.api.nvim_create_autocmd('FileType', {
  group = vim.api.nvim_create_augroup('plugins.auto-tag.lazy', { clear = true }),
  pattern = lazy_filetypes,
  once = true,
  callback = ensure_auto_tag_loaded,
})

if vim.tbl_contains(lazy_filetypes, vim.bo.filetype) then
  ensure_auto_tag_loaded()
end
