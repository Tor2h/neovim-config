local loaded = false

local function ensure_yazi_loaded()
  if loaded then
    return
  end

  loaded = true
  vim.pack.add({ 'https://github.com/mikavilpas/yazi.nvim' })
  require("yazi").setup()
end

local set = vim.keymap.set
set({ "n", "v" }, "<leader>-", function()
  ensure_yazi_loaded()
  vim.cmd("Yazi")
end, { desc = "Open yazi at the current file" })
set({ "n", "v" }, "<leader>cw", function()
  ensure_yazi_loaded()
  vim.cmd("Yazi cwd")
end, { desc = "Open the file manager in nvim's working directory" })
set({ "n", "v" }, "<c-y>", function()
  ensure_yazi_loaded()
  vim.cmd("Yazi toggle")
end, { desc = "Resume the last yazi session" })
