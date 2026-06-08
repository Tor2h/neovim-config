vim.pack.add({ 'https://github.com/seblyng/roslyn.nvim' })

local function is_windows()
  return vim.fn.has('win32') == 1 or vim.fn.has('win64') == 1
end

local function get_home_dir()
  return vim.env.USERPROFILE or vim.env.HOME
end

local function find_first_executable(candidates)
  for _, candidate in ipairs(candidates) do
    if candidate and candidate ~= '' and vim.fn.executable(candidate) == 1 then
      return candidate
    end
  end
end

local function get_roslyn_cmd()
  local data_dir = vim.fn.stdpath('data')
  local exe_matches = vim.fn.glob(vim.fs.joinpath(
    data_dir,
    'Microsoft.CodeAnalysis.LanguageServer.win-x64.*',
    'content',
    'LanguageServer',
    'win-x64',
    'Microsoft.CodeAnalysis.LanguageServer.exe'
  ), false, true)

  if #exe_matches > 0 then
    table.sort(exe_matches)
    return {
      exe_matches[#exe_matches],
      '--logLevel=Information',
      '--extensionLogDirectory=' .. data_dir,
      '--stdio',
    }
  end

  local dll_matches = vim.fn.glob(vim.fs.joinpath(
    data_dir,
    'Microsoft.CodeAnalysis.LanguageServer.win-x64.*',
    'content',
    'LanguageServer',
    'win-x64',
    'Microsoft.CodeAnalysis.LanguageServer.dll'
  ), false, true)

  if #dll_matches > 0 and vim.fn.executable('dotnet') == 1 then
    table.sort(dll_matches)
    return {
      'dotnet',
      dll_matches[#dll_matches],
      '--logLevel=Information',
      '--extensionLogDirectory=' .. data_dir,
      '--stdio',
    }
  end

  local home_dir = get_home_dir()
  local roslyn_language_server = find_first_executable({
    home_dir and vim.fs.joinpath(home_dir, '.dotnet', 'tools', is_windows() and 'roslyn-language-server.cmd'
      or 'roslyn-language-server'),
    is_windows() and 'roslyn-language-server.cmd' or 'roslyn-language-server',
  })

  if roslyn_language_server then
    return {
      roslyn_language_server,
      '--stdio',
    }
  end
end

local roslyn_cmd = get_roslyn_cmd()
if roslyn_cmd then
  vim.lsp.config('roslyn', {
    cmd = roslyn_cmd,
    -- handlers = {
    --   ['textDocument/publishDiagnostics'] = function() end,
    --   ['textDocument/diagnostic'] = function(err, result, ctx)
    --     if ctx and ctx.params then
    --       ctx.params.identifier = 'roslyn'
    --     end
    --     vim.lsp.diagnostic.on_diagnostic(err, result, ctx)
    --   end,
    -- },
  })
end

require('roslyn').setup({
  -- on_attach = function(client)
  -- client.server_capabilities.documentFormattingProvider = false
  -- client.server_capabilities.documentRangeFormattingProvider = false
  -- end,
})
