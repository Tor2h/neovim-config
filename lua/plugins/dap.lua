vim.pack.add({ 'https://github.com/mfussenegger/nvim-dap' })
vim.pack.add({ 'https://github.com/nvim-neotest/nvim-nio' })
vim.pack.add({ 'https://github.com/rcarriga/nvim-dap-ui' })

local dap = require('dap')
local dapui = require('dapui')

-- ── js-debug (vscode-js-debug) adapter ────────────────────────────────────────
-- Downloaded from https://github.com/microsoft/vscode-js-debug/releases
local js_debug_server = vim.fn.expand('$LOCALAPPDATA\\js-debug\\js-debug\\src\\dapDebugServer.js')

for _, adapter in ipairs({ 'pwa-chrome', 'pwa-msedge', 'chrome', 'msedge' }) do
  dap.adapters[adapter] = {
    type = 'server',
    host = 'localhost',
    port = '${port}',
    executable = {
      command = 'node',
      args = { js_debug_server, '${port}' },
    },
  }
end

-- ── JavaScript / TypeScript configurations ────────────────────────────────────
local js_config = {
  {
    type = 'pwa-chrome',
    request = 'launch',
    name = 'Launch Chrome (nx serve)',
    url = 'http://localhost:4200',
    webRoot = '${workspaceFolder}',
    sourceMaps = true,
    runtimeExecutable = 'chrome',
    runtimeArgs = { '--remote-debugging-port=9222' },
  },
  {
    type = 'pwa-chrome',
    request = 'attach',
    name = 'Attach Chrome (remote debug port 9222)',
    port = 9222,
    url = 'http://localhost:4200',
    webRoot = '${workspaceFolder}',
    sourceMaps = true,
  },
  {
    type = 'pwa-msedge',
    request = 'launch',
    name = 'Launch Edge (nx serve)',
    url = 'http://localhost:4200',
    webRoot = '${workspaceFolder}',
    sourceMaps = true,
  },
}

for _, lang in ipairs({ 'javascript', 'typescript', 'javascriptreact', 'typescriptreact' }) do
  dap.configurations[lang] = js_config
end

-- ── netcoredbg adapter ────────────────────────────────────────────────────────
-- Install netcoredbg from https://github.com/Samsung/netcoredbg/releases
-- and extract it to %USERPROFILE%\netcoredbg\
local netcoredbg = (vim.env.LOCALAPPDATA or (vim.env.USERPROFILE .. '\\AppData\\Local'))
    .. '\\Microsoft\\WinGet\\Packages\\Samsung.NetCoreDbg_Microsoft.Winget.Source_8wekyb3d8bbwe\\netcoredbg\\netcoredbg.exe'

dap.adapters.coreclr = {
  type = 'executable',
  command = netcoredbg,
  args = { '--interpreter=vscode' },
}

-- ── .NET configurations ───────────────────────────────────────────────────────
dap.configurations.cs = {
  {
    type = 'coreclr',
    name = 'Attach (pick process)',
    request = 'attach',
    processId = function()
      -- Filters to processes whose command line contains the API DLL name,
      -- excluding the `dotnet watch` orchestrator process.
      return require('dap.utils').pick_process({ filter = 'Renomatic.Backend.Api' })
    end,
    justMyCode = false,
  },
  {
    type = 'coreclr',
    name = 'Launch API (Development)',
    request = 'launch',
    program = function()
      -- Find the built DLL next to the csproj
      local csproj = vim.fn.findfile('Renomatic.Backend.Api.csproj', '.;**')
      if csproj == '' then
        return vim.fn.input('Path to DLL: ', vim.fn.getcwd() .. '\\', 'file')
      end
      local project_dir = vim.fn.fnamemodify(csproj, ':h')
      local dll = vim.fn.glob(project_dir .. '\\bin\\Debug\\**\\Renomatic.Backend.Api.dll', false, true)
      if #dll > 0 then
        return dll[1]
      end
      return vim.fn.input('Path to DLL: ', project_dir .. '\\bin\\Debug\\', 'file')
    end,
    cwd = '${workspaceFolder}',
    env = {
      ASPNETCORE_ENVIRONMENT = 'Development',
      ASPNETCORE_URLS = 'http://localhost:57000;https://localhost:44332',
    },
    stopAtEntry = false,
    console = 'internalConsole',
  },
}

-- ── dap-ui setup ──────────────────────────────────────────────────────────────
dapui.setup({
  icons = { expanded = '▾', collapsed = '▸', current_frame = '▸' },
  layouts = {
    {
      elements = {
        { id = 'scopes',      size = 0.40 },
        { id = 'breakpoints', size = 0.20 },
        { id = 'stacks',      size = 0.20 },
        { id = 'watches',     size = 0.20 },
      },
      size = 40,
      position = 'left',
    },
    {
      elements = {
        { id = 'repl',    size = 0.5 },
        { id = 'console', size = 0.5 },
      },
      size = 12,
      position = 'bottom',
    },
  },
})

-- Auto-open/close UI with debug sessions
dap.listeners.after.event_initialized['dapui_config'] = function() dapui.open() end
dap.listeners.before.event_terminated['dapui_config'] = function() dapui.close() end
dap.listeners.before.event_exited['dapui_config'] = function() dapui.close() end

-- ── Keymaps ───────────────────────────────────────────────────────────────────
local map = vim.keymap.set
map('n', '<F5>', dap.continue, { desc = 'DAP Continue / Start' })
map('n', '<F10>', dap.step_over, { desc = 'DAP Step Over' })
map('n', '<F11>', dap.step_into, { desc = 'DAP Step Into' })
map('n', '<S-F11>', dap.step_out, { desc = 'DAP Step Out' })
map('n', '<F9>', dap.toggle_breakpoint, { desc = 'DAP Toggle Breakpoint' })
map('n', '<leader>bb', dap.toggle_breakpoint, { desc = 'DAP Toggle Breakpoint' })
map('n', '<leader>bB', function()
  dap.set_breakpoint(vim.fn.input('Condition: '))
end, { desc = 'DAP Conditional Breakpoint' })
map('n', '<leader>bc', dap.continue, { desc = 'DAP Continue' })
map('n', '<leader>bi', dap.step_into, { desc = 'DAP Step Into' })
map('n', '<leader>bo', dap.step_over, { desc = 'DAP Step Over' })
map('n', '<leader>bO', dap.step_out, { desc = 'DAP Step Out' })
map('n', '<leader>br', dap.repl.open, { desc = 'DAP REPL' })
map('n', '<leader>bl', dap.run_last, { desc = 'DAP Run Last' })
map('n', '<leader>bq', dap.terminate, { desc = 'DAP Terminate' })
map('n', '<leader>bu', dapui.toggle, { desc = 'DAP UI Toggle' })
map('n', '<leader>be', function()
  dapui.eval(nil, { enter = true })
end, { desc = 'DAP Eval expression' })
map('v', '<leader>de', function()
  dapui.eval(nil, { enter = true })
end, { desc = 'DAP Eval selection' })
