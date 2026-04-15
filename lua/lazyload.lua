local M = {}

local vim_enter_queue = {}

local function drain(queue)
  for _, entry in ipairs(queue) do
    if not entry.sync then
      vim.schedule(entry.fn)
    end
  end

  for _, entry in ipairs(queue) do
    if entry.sync then
      entry.fn()
    end
  end
end

vim.api.nvim_create_autocmd("VimEnter", {
  group = vim.api.nvim_create_augroup("config.lazyload", { clear = true }),
  once = true,
  callback = function()
    if not vim_enter_queue then
      return
    end

    local queue = vim_enter_queue
    vim_enter_queue = nil
    drain(queue)
  end,
})

function M.on_vim_enter(fn, opts)
  local sync = opts and opts.sync or false

  if vim_enter_queue then
    table.insert(vim_enter_queue, { fn = fn, sync = sync })
  elseif sync then
    fn()
  else
    vim.schedule(fn)
  end
end

function M.require_module(module_name)
  return function()
    require(module_name)
  end
end

function M.require_modules(module_names)
  return function()
    for _, module_name in ipairs(module_names) do
      require(module_name)
    end
  end
end

function M.require_on_vim_enter(module_name, opts)
  M.on_vim_enter(M.require_module(module_name), opts)
end

function M.require_modules_on_vim_enter(module_names, opts)
  M.on_vim_enter(M.require_modules(module_names), opts)
end

return M
