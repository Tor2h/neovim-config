local M = {}

local function replace_site_prefix(paths, old_site_dir, new_site_dir)
  local normalized_old_site_dir = vim.fs.normalize(old_site_dir)
  local normalized_new_site_dir = vim.fs.normalize(new_site_dir)

  return vim.tbl_map(function(path)
    local normalized_path = vim.fs.normalize(path)

    if normalized_path == normalized_old_site_dir then
      return normalized_new_site_dir
    end

    if normalized_path:find(normalized_old_site_dir, 1, true) == 1 then
      return normalized_new_site_dir .. normalized_path:sub(#normalized_old_site_dir + 1)
    end

    return normalized_path
  end, paths)
end

function M.setup()
  if vim.fn.has('win32') == 0 then
    return
  end

  local local_app_data = vim.env.LOCALAPPDATA

  if not local_app_data or local_app_data == '' then
    return
  end

  local current_data_dir = vim.fn.stdpath('data')
  local redirected_data_home = vim.env.NVIM_LOCAL_DATA_HOME
    or vim.fs.joinpath(local_app_data, 'nvim-local-user')

  if vim.fs.normalize(current_data_dir):find(vim.fs.normalize(redirected_data_home), 1, true) == 1 then
    return
  end

  local current_site_dir = vim.fs.joinpath(current_data_dir, 'site')

  vim.env.XDG_DATA_HOME = redirected_data_home

  local redirected_data_dir = vim.fn.stdpath('data')
  local redirected_site_dir = vim.fs.joinpath(redirected_data_dir, 'site')

  vim.fn.mkdir(redirected_site_dir, 'p')

  vim.opt.packpath = replace_site_prefix(vim.opt.packpath:get(), current_site_dir, redirected_site_dir)
  vim.opt.runtimepath = replace_site_prefix(vim.opt.runtimepath:get(), current_site_dir, redirected_site_dir)
end

return M
