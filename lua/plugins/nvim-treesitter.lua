local function enable_treesitter(bufnr)
  if not vim.api.nvim_buf_is_valid(bufnr) then
    return
  end

  local filetype = vim.bo[bufnr].filetype
  if vim.bo[bufnr].buftype ~= "" or filetype == "" then
    return
  end

  pcall(vim.treesitter.start, bufnr)

  if filetype ~= 'cs' then
    vim.bo[bufnr].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
  end
end

require("lazyload").on_vim_enter(function()
  vim.pack.add({
    {
      src = "https://github.com/nvim-treesitter/nvim-treesitter",
      version = "main",
    },
  })

  vim.g.treesitter_install_dir = vim.fn.stdpath('data') .. '/treesitter'
  require('nvim-treesitter.install').compilers = { 'zig' }

  require('nvim-treesitter').setup({})

  vim.api.nvim_create_autocmd('FileType', {
    group = vim.api.nvim_create_augroup('plugins.nvim-treesitter.filetype', { clear = true }),
    callback = function(args)
      enable_treesitter(args.buf)
    end,
  })

  for _, bufnr in ipairs(vim.api.nvim_list_bufs()) do
    enable_treesitter(bufnr)
  end

  local ensureInstalled = {
    'angular',
    'c_sharp',
    'html',
    'javascript',
    'typescript',
    'tsx',
    'css',
    'scss',
    'rust',
    'typst',
  }

  local alreadyInstalled = require('nvim-treesitter.config').get_installed()
  local parsersToInstall = vim.iter(ensureInstalled)
      :filter(function(parser)
        return not vim.tbl_contains(alreadyInstalled, parser)
      end)
      :totable()

  if #parsersToInstall > 0 then
    require('nvim-treesitter').install(parsersToInstall)
  end

  vim.api.nvim_create_autocmd('PackChanged', {
    desc = 'Handle nvim-treesitter updates',
    group = vim.api.nvim_create_augroup('nvim-treesitter-pack-changed-update-handler', { clear = true }),
    callback = function(event)
      if event.data.kind == 'update' and event.data.spec.name == 'nvim-treesitter' then
        vim.notify('nvim-treesitter updated, running TSUpdate...', vim.log.levels.INFO)
        local ok = pcall(vim.cmd, 'TSUpdate')
        if ok then
          vim.notify('TSUpdate completed successfully!', vim.log.levels.INFO)
        else
          vim.notify('TSUpdate command not available yet, skipping', vim.log.levels.WARN)
        end
      end
    end,
  })
end)
