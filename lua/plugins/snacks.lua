vim.pack.add({ 'https://github.com/folke/snacks.nvim' })

require("snacks").setup({
  bigfile = { enabled = true },
  dashboard = {
    enabled = false,
  },
  explorer = { enabled = true },
  indent = { enabled = false },
  input = { enabled = true },
  notifier = { enabled = true, timeout = 3000 },
  picker = {
    hidden = true,
    enabled = true,
    sources = {
      explorer = {
        auto_close = true,
        jump = { close = true },
        layout = { preset = "default", preview = false },
      },
    },
  },
  quickfile = { enabled = true },
  scope = { enabled = true },
  scroll = { enabled = true },
  statuscolumn = { enabled = true },
  words = { enabled = true },
  image = { enabled = false },
  styles = {
    notification = { wo = { wrap = true } },
  },
  zen = {
    toggles = {
      dim = false,
      git_signs = true,
      mini_diff_signs = true,
    },
    center = true,
    show = { statusline = true, tabline = true },
    win = { style = "zen" },
    on_open = function(win) end,
    on_close = function(win) end,
    zoom = {
      toggles = {},
      center = false,
      show = { statusline = true, tabline = true },
      win = { backdrop = false, width = 0 },
    },
  }
})

local function map(mode, lhs, rhs, opts)
  local options = { noremap = true, silent = true }
  if opts then options = vim.tbl_extend("force", options, opts) end
  vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

-- Top Pickers & Explorer
map("n", "<leader>hh", "<cmd>lua require('snacks.picker').yanky()<CR>", { desc = "Open Yank History" })
map("x", "<leader>hh", "<cmd>lua require('snacks.picker').yanky()<CR>", { desc = "Open Yank History" })
map("n", "<leader>e", "<cmd>lua require('snacks.picker').smart()<CR>", { desc = "Smart Find Files" })
map("n", "<leader>,", "<cmd>lua require('snacks.picker').buffers()<CR>", { desc = "Buffers" })
map("n", "<leader>/", "<cmd>lua require('snacks.picker').grep()<CR>", { desc = "Grep" })
map("n", "<leader>:", "<cmd>lua require('snacks.picker').command_history()<CR>", { desc = "Command History" })
map("n", "<leader>n", "<cmd>lua require('snacks.picker').notifications()<CR>", { desc = "Notification History" })
map("n", "<leader>n", "<cmd>lua require('snacks').explorer()<CR>", { desc = "File Explorer" })

-- Find
map("n", "<leader>fb", "<cmd>lua require('snacks.picker').buffers()<CR>", { desc = "Buffers" })
map("n", "<leader>fc", "<cmd>lua require('snacks.picker').files({ cwd = vim.fn.stdpath('config') })<CR>",
  { desc = "Find Config File" })
map("n", "<leader><CR>", "<cmd>lua require('snacks.picker').files()<CR>", { desc = "Find Files" })
map("n", "<leader>fg", "<cmd>lua require('snacks.picker').git_files()<CR>", { desc = "Find Git Files" })
map("n", "<leader>fp", "<cmd>lua require('snacks.picker').projects()<CR>", { desc = "Projects" })
map("n", "<leader>fr", "<cmd>lua require('snacks.picker').recent()<CR>", { desc = "Recent" })

-- Git
map("n", "<leader>gb", "<cmd>lua require('snacks.picker').git_branches()<CR>", { desc = "Git Branches" })
map("n", "<leader>gl", "<cmd>lua require('snacks.picker').git_log()<CR>", { desc = "Git Log" })
map("n", "<leader>gL", "<cmd>lua require('snacks.picker').git_log_line()<CR>", { desc = "Git Log Line" })
map("n", "<leader>gs", "<cmd>lua require('snacks.picker').git_status()<CR>", { desc = "Git Status" })
map("n", "<leader>gS", "<cmd>lua require('snacks.picker').git_stash()<CR>", { desc = "Git Stash" })
map("n", "<leader>gd", "<cmd>lua require('snacks.picker').git_diff()<CR>", { desc = "Git Diff (Hunks)" })
map("n", "<leader>gf", "<cmd>lua require('snacks.picker').git_log_file()<CR>", { desc = "Git Log File" })

-- Grep
map("n", "<leader>sb", "<cmd>lua require('snacks.picker').lines()<CR>", { desc = "Buffer Lines" })
map("n", "<leader>sB", "<cmd>lua require('snacks.picker').grep_buffers()<CR>", { desc = "Grep Open Buffers" })
map("n", "<leader>sg", "<cmd>lua require('snacks.picker').grep()<CR>", { desc = "Grep" })
map("n", "<leader>sw", "<cmd>lua require('snacks.picker').grep_word()<CR>",
  { desc = "Visual selection or word" })
map("x", "<leader>sw", "<cmd>lua require('snacks.picker').grep_word()<CR>",
  { desc = "Visual selection or word" })

-- Search
map("n", '<leader>s"', "<cmd>lua require('snacks.picker').registers()<CR>", { desc = "Registers" })
map("n", "<leader>s/", "<cmd>lua require('snacks.picker').search_history()<CR>", { desc = "Search History" })
map("n", "<leader>sa", "<cmd>lua require('snacks.picker').autocmds()<CR>", { desc = "Autocmds" })
map("n", "<leader>sc", "<cmd>lua require('snacks.picker').command_history()<CR>", { desc = "Command History" })
map("n", "<leader>sC", "<cmd>lua require('snacks.picker').commands()<CR>", { desc = "Commands" })
map("n", "<leader>sd", "<cmd>lua require('snacks.picker').diagnostics()<CR>", { desc = "Diagnostics" })
map("n", "<leader>sD", "<cmd>lua require('snacks.picker').diagnostics_buffer()<CR>", { desc = "Buffer Diagnostics" })
map("n", "<leader>sh", "<cmd>lua require('snacks.picker').help()<CR>", { desc = "Help Pages" })
map("n", "<leader>sH", "<cmd>lua require('snacks.picker').highlights()<CR>", { desc = "Highlights" })
map("n", "<leader>si", "<cmd>lua require('snacks.picker').icons()<CR>", { desc = "Icons" })
map("n", "<leader>sj", "<cmd>lua require('snacks.picker').jumps()<CR>", { desc = "Jumps" })
map("n", "<leader>sk", "<cmd>lua require('snacks.picker').keymaps()<CR>", { desc = "Keymaps" })
map("n", "<leader>sl", "<cmd>lua require('snacks.picker').loclist()<CR>", { desc = "Location List" })
map("n", "<leader>sm", "<cmd>lua require('snacks.picker').marks()<CR>", { desc = "Marks" })
map("n", "<leader>sM", "<cmd>lua require('snacks.picker').man()<CR>", { desc = "Man Pages" })
map("n", "<leader>sq", "<cmd>lua require('snacks.picker').qflist()<CR>", { desc = "Quickfix List" })
map("n", "<leader>sR", "<cmd>lua require('snacks.picker').resume()<CR>", { desc = "Resume" })
map("n", "<leader>su", "<cmd>lua require('snacks.picker').undo()<CR>", { desc = "Undo History" })
map("n", "<leader>uC", "<cmd>lua require('snacks.picker').colorschemes()<CR>", { desc = "Colorschemes" })

-- LSP
map("n", "gd", "<cmd>lua require('snacks.picker').lsp_definitions()<CR>", { desc = "Goto Definition" })
map("n", "gD", "<cmd>lua require('snacks.picker').lsp_declarations()<CR>", { desc = "Goto Declaration" })
map("n", "grr", "<cmd>lua require('snacks.picker').lsp_references()<CR>", { desc = "References" })
map("n", "gI", "<cmd>lua require('snacks.picker').lsp_implementations()<CR>", { desc = "Goto Implementation" })
map("n", "gy", "<cmd>lua require('snacks.picker').lsp_type_definitions()<CR>", { desc = "Goto T[y]pe Definition" })
map("n", "<leader>fs", "<cmd>lua require('snacks.picker').lsp_symbols()<CR>", { desc = "LSP Symbols" })
map("n", "<leader>sf", "<cmd>lua require('snacks.picker').lsp_workspace_symbols()<CR>",
  { desc = "LSP Workspace Symbols" })

-- Other
map("n", "<leader>Z", "<cmd>lua require('snacks.zen').zoom()<CR>", { desc = "Toggle Zoom" })
map("n", "<leader>.", "<cmd>lua require('snacks').scratch()<CR>", { desc = "Toggle Scratch Buffer" })
map("n", "<leader>S", "<cmd>lua require('snacks.scratch').select()<CR>", { desc = "Select Scratch Buffer" })
map("n", "<leader>un", "<cmd>lua require('snacks.notifier').show_history()<CR>", { desc = "Notification History" })
map("n", "<leader>bd", "<cmd>lua require('snacks').bufdelete()<CR>", { desc = "Delete Buffer" })
map("n", "<leader>cR", "<cmd>lua require('snacks.rename').rename_file()<CR>", { desc = "Rename File" })
map("n", "<leader>gB", "<cmd>lua require('snacks').gitbrowse()<CR>", { desc = "Git Browse" })
map("v", "<leader>gB", "<cmd>lua require('snacks').gitbrowse()<CR>", { desc = "Git Browse" })
map("n", "<leader>gg", "<cmd>lua require('snacks').lazygit()<CR>", { desc = "Lazygit" })
map("n", "<leader>uN", "<cmd>lua require('snacks.notifier').hide()<CR>", { desc = "Dismiss All Notifications" })
map("t", "<c-/>", "<cmd>lua require('snacks').terminal()<CR>", { desc = "Toggle Terminal" })
map("n", "<c-/>", "<cmd>lua require('snacks').terminal()<CR>", { desc = "Toggle Terminal" })
map("n", "]]", "<cmd>lua require('snacks.words').jump(vim.v.count1)<CR>", { desc = "Next Reference" })
map("t", "]]", "<cmd>lua require('snacks.words').jump(vim.v.count1)<CR>", { desc = "Next Reference" })
map("n", "[[", "<cmd>lua require('snacks.words').jump(-vim.v.count1)<CR>", { desc = "Prev Reference" })
map("t", "[[", "<cmd>lua require('snacks.words').jump(-vim.v.count1)<CR>", { desc = "Prev Reference" })
map("n", "<leader>N",
  "<cmd>lua require('snacks.win')({ file = vim.api.nvim_get_runtime_file('doc/news.txt', false)[1], width = 0.6, height = 0.6, wo = { spell = false, wrap = false, signcolumn = 'yes', statuscolumn = ' ', conceallevel = 3 } })<CR>",
  { desc = "Neovim News" })
