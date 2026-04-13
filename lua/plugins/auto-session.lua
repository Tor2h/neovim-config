vim.pack.add({ 'https://github.com/rmagatti/auto-session' })

require("auto-session").setup({
  auto_restore = true,
  auto_save = true,
  bypass_save_filetypes = { "dashboard", "alpha" },
  session_lens = {
    load_on_setup = false,
  },
})
