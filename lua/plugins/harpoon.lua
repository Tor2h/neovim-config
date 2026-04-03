vim.pack.add({ 'https://github.com/nvim-lua/plenary.nvim' })
vim.pack.add({
  {
    src = "https://github.com/ThePrimeagen/harpoon",
    version = "harpoon2",
  },
})

local harpoon = require("harpoon")

vim.keymap.set("n", "<leader>a", function()
    harpoon:list():add()
  end,
  { desc = "harpoon file" })

vim.keymap.set("n", "<C-e>", function()
    harpoon.ui:toggle_quick_menu(harpoon:list())
  end,
  { desc = "harpoon quick menu" })

vim.keymap.set("n", "<A-m>", function()
    harpoon:list():select(1)
  end,
  { desc = "harpoon to file 1" })

vim.keymap.set("n", "<A-,>", function()
    harpoon:list():select(2)
  end,
  { desc = "harpoon to file 2" })

vim.keymap.set("n", "<A-.>", function()
    harpoon:list():select(3)
  end,
  { desc = "harpoon to file 3" })

vim.keymap.set("n", "<A-j>", function()
    harpoon:list():select(4)
  end,
  { desc = "harpoon to file 4" })

vim.keymap.set("n", "<A-k>", function()
    harpoon:list():select(5)
  end,
  { desc = "harpoon to file 5" })

vim.keymap.set("n", "<A-l>", function()
    harpoon:list():select(6)
  end,
  { desc = "harpoon to file 6" })

vim.keymap.set("n", "<A-u>", function()
    harpoon:list():select(7)
  end,
  { desc = "harpoon to file 7" })

vim.keymap.set("n", "<A-i>", function()
    harpoon:list():select(8)
  end,
  { desc = "harpoon to file 8" })

vim.keymap.set("n", "<A-o>", function()
    harpoon:list():select(9)
  end,
  { desc = "harpoon to file 9" })
