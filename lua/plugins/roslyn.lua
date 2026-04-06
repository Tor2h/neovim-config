vim.pack.add({ 'https://github.com/seblyng/roslyn.nvim' })

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
end

local roslyn_cmd = get_roslyn_cmd()
if roslyn_cmd then
  vim.lsp.config('roslyn', {
    cmd = roslyn_cmd,
  })
end

require('roslyn').setup({})
