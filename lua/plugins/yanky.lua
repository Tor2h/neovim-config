vim.pack.add({ 'https://github.com/gbprod/yanky.nvim' })
require("yanky").setup()

local set = vim.keymap.set
set({ "n", "x" }, "p", "<Plug>(YankyPutAfter)")
set({ "n", "x" }, "P", "<Plug>(YankyPutBefore)")
set({ "n", "x" }, "gp", "<Plug>(YankyGPutAfter)")
set({ "n", "x" }, "gP", "<Plug>(YankyGPutBefore)")

set("n", "<c-p>", "<Plug>(YankyPreviousEntry)")
set("n", "<c-n>", "<Plug>(YankyNextEntry)")
