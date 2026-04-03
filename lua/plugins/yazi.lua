vim.pack.add({ 'https://github.com/mikavilpas/yazi.nvim' })
require("yazi").setup()

local set = vim.keymap.set
set({ "n", "v" }, "<leader>-", "<cmd>Yazi<cr>", { desc = "Open yazi at the current file" })
set({ "n", "v" }, "<leader>cw", "<cmd>Yazi cwd<cr>", { desc = "Open the file manager in nvim's working directory" })
set({ "n", "v" }, "<c-y>", "<cmd>Yazi toggle<cr>", { desc = "Resume the last yazi session" })
