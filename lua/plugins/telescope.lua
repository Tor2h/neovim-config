local builtin

local ensure_telescope_loaded

ensure_telescope_loaded = function()
  if builtin then
    return builtin
  end

  vim.pack.add({
    'https://github.com/nvim-lua/plenary.nvim',
    'https://github.com/nvim-telescope/telescope.nvim',
    'https://github.com/nvim-telescope/telescope-fzf-native.nvim',
  })

  local telescope = require("telescope")
  telescope.setup({
    defaults = {
      path_display = { "filename_first", shorten = 5 },
      layout_strategy = 'horizontal',
      layout_config = { width = 0.95, height = 0.95 },
    },
    pickers = {
      find_files = {
        hidden = true,
      },
    },
    extensions = {
      fzf = {
        fuzzy = true,
        override_generic_sorter = true,
        override_file_sorter = true,
        case_mode = "smart_case",
      },
    },
  })

  pcall(telescope.load_extension, "fzf")
  pcall(telescope.load_extension, "yank_history")

  builtin = require("telescope.builtin")
  ensure_telescope_loaded = function()
    return builtin
  end
  return builtin
end

local function map(mode, lhs, rhs, opts)
  local options = { noremap = true, silent = true }
  if opts then options = vim.tbl_extend("force", options, opts) end
  vim.keymap.set(mode, lhs, rhs, options)
end

local function grep_visual_selection()
  local telescope_builtin = ensure_telescope_loaded()
  local save_reg = vim.fn.getreg('"')
  local save_regtype = vim.fn.getregtype('"')
  vim.cmd([[silent! normal! "vy]])
  local selection = vim.fn.getreg("v")
  vim.fn.setreg('"', save_reg, save_regtype)
  if selection and selection ~= "" then
    telescope_builtin.grep_string({ search = selection })
  end
end

-- Top Pickers & Explorer
map("n", "<leader>hh", function()
  ensure_telescope_loaded()
  vim.cmd("Telescope yank_history")
end, { desc = "Open Yank History" })
map("x", "<leader>hh", function()
  ensure_telescope_loaded()
  vim.cmd("Telescope yank_history")
end, { desc = "Open Yank History" })
map("n", "<leader>/", function()
  ensure_telescope_loaded().live_grep()
end, { desc = "Grep" })
map("n", "<leader>e", function()
  ensure_telescope_loaded().find_files()
end, { desc = "Find Files" })

-- Find
map("n", "<leader>fb", function()
  ensure_telescope_loaded().buffers()
end, { desc = "Buffers" })
map("n", "<leader>fc", function()
  ensure_telescope_loaded().find_files({ cwd = vim.fn.stdpath("config") })
end, { desc = "Find Config File" })
map("n", "<leader><CR>", function()
  ensure_telescope_loaded().find_files()
end, { desc = "Find Files" })
map("n", "<leader>fg", function()
  ensure_telescope_loaded().git_files()
end, { desc = "Find Git Files" })
map("n", "<leader>r", function()
  ensure_telescope_loaded().oldfiles()
end, { desc = "Recent" })

-- Git
map("n", "<leader>gb", function()
  ensure_telescope_loaded().git_branches()
end, { desc = "Git Branches" })
map("n", "<leader>gl", function()
  ensure_telescope_loaded().git_commits()
end, { desc = "Git Log" })
map("n", "<leader>gs", function()
  ensure_telescope_loaded().git_status()
end, { desc = "Git Status" })
map("n", "<leader>gS", function()
  ensure_telescope_loaded().git_stash()
end, { desc = "Git Stash" })
map("n", "<leader>gf", function()
  ensure_telescope_loaded().git_bcommits()
end, { desc = "Git Log File" })

-- Grep
map("n", "<leader>sb", function()
  ensure_telescope_loaded().current_buffer_fuzzy_find()
end, { desc = "Buffer Lines" })
map("n", "<leader>sB", function()
  ensure_telescope_loaded().live_grep({ grep_open_files = true })
end, { desc = "Grep Open Buffers" })
map("n", "<leader>sw", function()
  ensure_telescope_loaded().grep_string()
end, { desc = "Word Under Cursor" })
map("x", "<leader>sw", grep_visual_selection, { desc = "Visual Selection" })

-- Search
map("n", '<leader>s"', function()
  ensure_telescope_loaded().registers()
end, { desc = "Registers" })
map("n", "<leader>s/", function()
  ensure_telescope_loaded().search_history()
end, { desc = "Search History" })
map("n", "<leader>sa", function()
  ensure_telescope_loaded().autocommands()
end, { desc = "Autocmds" })
map("n", "<leader>sc", function()
  ensure_telescope_loaded().command_history()
end, { desc = "Command History" })
map("n", "<leader>sC", function()
  ensure_telescope_loaded().commands()
end, { desc = "Commands" })
map("n", "<leader>sd", function()
  ensure_telescope_loaded().diagnostics()
end, { desc = "Diagnostics" })
map("n", "<leader>sD", function()
  ensure_telescope_loaded().diagnostics({ bufnr = 0 })
end, { desc = "Buffer Diagnostics" })
map("n", "<leader>sh", function()
  ensure_telescope_loaded().help_tags()
end, { desc = "Help Pages" })
map("n", "<leader>sH", function()
  ensure_telescope_loaded().highlights()
end, { desc = "Highlights" })
map("n", "<leader>sj", function()
  ensure_telescope_loaded().jumplist()
end, { desc = "Jumps" })
map("n", "<leader>sk", function()
  ensure_telescope_loaded().keymaps()
end, { desc = "Keymaps" })
map("n", "<leader>sl", function()
  ensure_telescope_loaded().loclist()
end, { desc = "Location List" })
map("n", "<leader>sm", function()
  ensure_telescope_loaded().marks()
end, { desc = "Marks" })
map("n", "<leader>sM", function()
  ensure_telescope_loaded().man_pages()
end, { desc = "Man Pages" })
map("n", "<leader>sq", function()
  ensure_telescope_loaded().quickfix()
end, { desc = "Quickfix List" })
map("n", "<leader>sR", function()
  ensure_telescope_loaded().resume()
end, { desc = "Resume" })
map("n", "<leader>uC", function()
  ensure_telescope_loaded().colorscheme()
end, { desc = "Colorschemes" })

-- LSP
map("n", "gd", function()
  ensure_telescope_loaded().lsp_definitions()
end, { desc = "Goto Definition" })
map("n", "gD", vim.lsp.buf.declaration, { desc = "Goto Declaration" })
map("n", "grr", function()
  ensure_telescope_loaded().lsp_references()
end, { desc = "References" })
map("n", "gI", function()
  ensure_telescope_loaded().lsp_implementations()
end, { desc = "Goto Implementation" })
map("n", "gy", function()
  ensure_telescope_loaded().lsp_type_definitions()
end, { desc = "Goto T[y]pe Definition" })
map("n", "<leader>fs", function()
  ensure_telescope_loaded().lsp_document_symbols()
end, { desc = "LSP Symbols" })
map("n", "<leader>sf", function()
  ensure_telescope_loaded().lsp_dynamic_workspace_symbols()
end, { desc = "LSP Workspace Symbols" })
