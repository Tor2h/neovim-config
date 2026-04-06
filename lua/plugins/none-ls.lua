vim.pack.add({ 'https://github.com/nvimtools/none-ls.nvim' })
vim.pack.add({ 'https://github.com/nvimtools/none-ls-extras.nvim' })

local null_ls = require("null-ls")
local eslint_config_files = {
  ".eslintrc",
  ".eslintrc.js",
  ".eslintrc.cjs",
  ".eslintrc.json",
  ".eslintrc.yaml",
  ".eslintrc.yml",
  "eslint.config.js",
  "eslint.config.cjs",
  "eslint.config.mjs",
}
local eslint_diagnostics = require("none-ls.diagnostics.eslint").with({
  method = null_ls.methods.DIAGNOSTICS_ON_SAVE,
  filetypes = { "javascript", "typescript", "html", "htmlangular" },
  prefer_local = "node_modules/.bin",
  condition = function(utils)
    return utils.root_has_file(eslint_config_files)
        and utils.root_has_file({ "node_modules/eslint/package.json" })
  end,
})

local work_config_path = "C:/Users/th004/AppData/Local/nvim"

local current_config_dir = vim.fn.stdpath("config"):gsub("\\", "/")

if current_config_dir == work_config_path then
  null_ls.setup({
    sources = {
      eslint_diagnostics,
      null_ls.builtins.formatting.prettier,
    },
  })
end

vim.keymap.set({ "n", "v" }, "<leader>j", function()
  local bufnr = vim.api.nvim_get_current_buf() -- Get current buffer

  if vim.bo[bufnr].filetype == "cs" then
    vim.notify("Formatting is disabled for C# buffers", vim.log.levels.INFO)
    return
  end

  local clients = vim.lsp.get_clients({ bufnr = bufnr })
  local formatters = {}

  for _, c in pairs(clients) do
    if c.server_capabilities.documentFormattingProvider then
      table.insert(formatters, c.name)
    end
  end

  if #formatters > 1 then
    vim.ui.select(formatters, { prompt = "Select a formatter" }, function(choice, _)
      if not choice then
        return
      end
      vim.lsp.buf.format({ async = true, name = choice })
    end)
  else
    vim.lsp.buf.format({ async = true, name = formatters[1] })
  end
end, { desc = "Format" })
