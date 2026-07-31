vim.pack.add({
  'https://github.com/nvim-lua/plenary.nvim',
  'https://github.com/nvim-telescope/telescope.nvim',
  'https://github.com/nvim-telescope/telescope-fzf-native.nvim',
})

local telescope = require("telescope")
telescope.setup({
  defaults = {
    path_display = { "filename_first", shorten = 5 },
    wrap_results = true,
    layout_strategy = 'horizontal',
    layout_config = { width = 0.95, height = 0.95 },
  },
  pickers = {
    find_files = {
      hidden = true,
    },
    colorscheme = {
      enable_preview = true,
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

local builtin = require("telescope.builtin")

local function map(mode, lhs, rhs, opts)
  local options = { noremap = true, silent = true }
  if opts then options = vim.tbl_extend("force", options, opts) end
  vim.keymap.set(mode, lhs, rhs, options)
end

local function grep_visual_selection()
  local save_reg = vim.fn.getreg('"')
  local save_regtype = vim.fn.getregtype('"')
  vim.cmd([[silent! normal! "vy]])
  local selection = vim.fn.getreg("v")
  vim.fn.setreg('"', save_reg, save_regtype)
  if selection and selection ~= "" then
    builtin.grep_string({ search = selection })
  end
end

-- Top Pickers & Explorer
map("n", "<leader>hh", "<cmd>Telescope yank_history<CR>", { desc = "Open Yank History" })
map("x", "<leader>hh", "<cmd>Telescope yank_history<CR>", { desc = "Open Yank History" })
map("n", "<leader>,", builtin.buffers, { desc = "Buffers" })
map("n", "<leader>/", builtin.live_grep, { desc = "Grep" })
map("n", "<leader>:", builtin.command_history, { desc = "Command History" })
map("n", "<leader>e", builtin.find_files, { desc = "Find Files" })

-- Find
map("n", "<leader>fb", builtin.buffers, { desc = "Buffers" })
map("n", "<leader>fc", function() builtin.find_files({ cwd = vim.fn.stdpath("config") }) end,
  { desc = "Find Config File" })
map("n", "<leader><CR>", builtin.find_files, { desc = "Find Files" })
map("n", "<leader>fg", builtin.git_files, { desc = "Find Git Files" })
map("n", "<leader>fp", builtin.oldfiles, { desc = "Projects/Recent Files" })
map("n", "<leader>fr", builtin.oldfiles, { desc = "Recent" })

-- Git
map("n", "<leader>gb", builtin.git_branches, { desc = "Git Branches" })
map("n", "<leader>gl", builtin.git_commits, { desc = "Git Log" })
map("n", "<leader>gL", builtin.git_bcommits, { desc = "Git Log Line/File" })
map("n", "<leader>gs", builtin.git_status, { desc = "Git Status" })
map("n", "<leader>gS", builtin.git_stash, { desc = "Git Stash" })
map("n", "<leader>gd", builtin.git_status, { desc = "Git Diff (Status)" })
map("n", "<leader>gf", builtin.git_bcommits, { desc = "Git Log File" })

-- Grep
map("n", "<leader>sb", builtin.current_buffer_fuzzy_find, { desc = "Buffer Lines" })
map("n", "<leader>sB", function() builtin.live_grep({ grep_open_files = true }) end, { desc = "Grep Open Buffers" })
map("n", "<leader>sg", builtin.live_grep, { desc = "Grep" })
map("n", "<leader>sw", builtin.grep_string, { desc = "Word Under Cursor" })
map("x", "<leader>sw", grep_visual_selection, { desc = "Visual Selection" })

-- Search
map("n", '<leader>s"', builtin.registers, { desc = "Registers" })
map("n", "<leader>s/", builtin.search_history, { desc = "Search History" })
map("n", "<leader>sa", builtin.autocommands, { desc = "Autocmds" })
map("n", "<leader>sc", builtin.command_history, { desc = "Command History" })
map("n", "<leader>sC", builtin.commands, { desc = "Commands" })
map("n", "<leader>sd", builtin.diagnostics, { desc = "Diagnostics" })
map("n", "<leader>sD", function() builtin.diagnostics({ bufnr = 0 }) end, { desc = "Buffer Diagnostics" })
map("n", "<leader>sh", builtin.help_tags, { desc = "Help Pages" })
map("n", "<leader>sH", builtin.highlights, { desc = "Highlights" })
map("n", "<leader>sj", builtin.jumplist, { desc = "Jumps" })
map("n", "<leader>sk", builtin.keymaps, { desc = "Keymaps" })
map("n", "<leader>sl", builtin.loclist, { desc = "Location List" })
map("n", "<leader>sm", builtin.marks, { desc = "Marks" })
map("n", "<leader>sM", builtin.man_pages, { desc = "Man Pages" })
map("n", "<leader>sq", builtin.quickfix, { desc = "Quickfix List" })
map("n", "<leader>sR", builtin.resume, { desc = "Resume" })
map("n", "<leader>uC", builtin.colorscheme, { desc = "Colorschemes" })

-- LSP
map("n", "gd", builtin.lsp_definitions, { desc = "Goto Definition" })
map("n", "gD", vim.lsp.buf.declaration, { desc = "Goto Declaration" })
map("n", "grr", builtin.lsp_references, { desc = "References" })
map("n", "gI", builtin.lsp_implementations, { desc = "Goto Implementation" })
map("n", "gy", builtin.lsp_type_definitions, { desc = "Goto T[y]pe Definition" })
map("n", "<leader>fs", builtin.lsp_document_symbols, { desc = "LSP Symbols" })
map("n", "<leader>sf", builtin.lsp_dynamic_workspace_symbols,
  { desc = "LSP Workspace Symbols" })
