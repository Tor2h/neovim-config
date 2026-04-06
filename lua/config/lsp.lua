vim.lsp.enable('angularls')
vim.lsp.enable('vscode-css-language-server')
vim.lsp.enable('vscode-json-language-server')
vim.lsp.enable('lua_ls')
vim.lsp.enable('marksman')
vim.lsp.enable('rnix')
vim.lsp.enable('rust_analyzer')
vim.lsp.enable('vscode-html-language-server')
vim.lsp.enable('svelte')
vim.lsp.enable('taplo')
vim.lsp.enable('tinymist')
vim.lsp.enable('ts_ls')

local function is_csharp_buffer(bufnr)
  return vim.bo[bufnr].filetype == 'cs'
end

vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('my.lsp', {}),
  callback = function(args)
    local client = assert(vim.lsp.get_client_by_id(args.data.client_id))
    local is_csharp = is_csharp_buffer(args.buf)

    if is_csharp then
      client.server_capabilities.documentFormattingProvider = false
      client.server_capabilities.documentRangeFormattingProvider = false
    end

    if client:supports_method('textDocument/implementation') then
      vim.keymap.set('n', 'gi', function()
        vim.lsp.buf.implementation()
      end)
    end
    -- Auto-format ("lint") on save.
    -- Usually not needed if server supports "textDocument/willSaveWaitUntil".
    if not is_csharp
        and not client:supports_method('textDocument/willSaveWaitUntil')
        and client:supports_method('textDocument/formatting') then
      vim.api.nvim_create_autocmd('BufWritePre', {
        group = vim.api.nvim_create_augroup('my.lsp', { clear = false }),
        buffer = args.buf,
        callback = function()
          vim.lsp.buf.format({ bufnr = args.buf, id = client.id, timeout_ms = 1000 })
        end,
      })
    end
  end,
})

vim.diagnostic.config({
  virtual_lines = {
    current_line = true,
  },
})
