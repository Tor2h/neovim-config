local ensure_render_markdown_loaded

ensure_render_markdown_loaded = function()
  vim.pack.add({ 'https://github.com/MeanderingProgrammer/render-markdown.nvim' })
  require("render-markdown").setup()

  ensure_render_markdown_loaded = function() end
end

vim.api.nvim_create_autocmd('FileType', {
  group = vim.api.nvim_create_augroup('plugins.render-markdown.lazy', { clear = true }),
  pattern = { 'markdown' },
  callback = ensure_render_markdown_loaded,
})

if vim.bo.filetype == 'markdown' then
  ensure_render_markdown_loaded()
end
