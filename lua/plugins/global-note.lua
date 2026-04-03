vim.pack.add({ 'https://github.com/backdround/global-note.nvim' })

-- Helper function for getting the project name
local get_project_name = function()
  local result = vim.system({
    "git",
    "rev-parse",
    "--show-toplevel",
  }, {
    text = true,
  }):wait()

  if result.stderr ~= "" then
    vim.notify(result.stderr, vim.log.levels.WARN)
    return nil
  end

  local project_directory = result.stdout:gsub("\n", "")
  local project_name = vim.fs.basename(project_directory)
  if project_name == nil then
    vim.notify("Unable to get the project name", vim.log.levels.WARN)
    return nil
  end

  return project_name
end

require('global-note').setup({
  autosave = false,
  directory = "/home/tor/Notes/",
  filename = "global.md",
  additional_presets = {
    project_private = {
      directory = function()
        return vim.fs.joinpath("/home/tor/Notes/", get_project_name())
      end,
      filename = "note.md",
      title = "Private Project Note",
      command_name = "ProjectPrivateNote",
    },
    project_local = {
      directory = function()
        return vim.fn.getcwd()
      end,
      filename = "note.md",
      title = "Project Note",
      command_name = "ProjectNote",
    },
    project_todo = {
      directory = function()
        return vim.fn.getcwd()
      end,
      filename = "todo.md",
      title = "Project Todo",
      command_name = "ProjectTodo",
    },
  },
})

vim.api.nvim_set_keymap('n', '<leader>m', '<CMD>ProjectPrivateNote<CR>',
  { desc = "Private Notes", noremap = true, silent = true })
