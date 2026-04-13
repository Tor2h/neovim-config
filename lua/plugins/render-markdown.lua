local loaded = false

local function ensure_render_markdown_loaded()
  if loaded then
    return
  end

  loaded = true
  vim.pack.add({ 'https://github.com/MeanderingProgrammer/render-markdown.nvim' })
  require("render-markdown").setup()
end

vim.api.nvim_create_autocmd('FileType', {
  group = vim.api.nvim_create_augroup('plugins.render-markdown.lazy', { clear = true }),
  pattern = { 'markdown' },
  callback = ensure_render_markdown_loaded,
})
