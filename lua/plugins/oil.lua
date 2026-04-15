local ensure_oil_loaded

ensure_oil_loaded = function()
  vim.pack.add({ 'https://github.com/stevearc/oil.nvim' })
  require("oil").setup({
    default_file_explorer = true,
    columns = {
      "icon",
    },
    buf_options = {
      buflisted = false,
      bufhidden = "hide",
    },
    win_options = {
      wrap = false,
      signcolumn = "no",
      cursorcolumn = false,
      foldcolumn = "0",
      spell = false,
      list = false,
      conceallevel = 3,
      concealcursor = "nvic",
    },
    delete_to_trash = false,
    skip_confirm_for_simple_edits = false,
    prompt_save_on_select_new_entry = true,
    cleanup_delay_ms = 2000,
    lsp_file_methods = {
      enabled = true,
      timeout_ms = 1000,
      autosave_changes = false,
    },
    constrain_cursor = "editable",
    watch_for_changes = false,
    keymaps = {
      ["g?"] = { "actions.show_help", mode = "n" },
      ["<CR>"] = "actions.select",
      ["<C-s>"] = { "actions.select", opts = { vertical = true } },
      ["<C-h>"] = { "actions.select", opts = { horizontal = true } },
      ["<C-t>"] = { "actions.select", opts = { tab = true } },
      ["<C-p>"] = "actions.preview",
      ["<C-c>"] = { "actions.close", mode = "n" },
      ["<C-l>"] = "actions.refresh",
      ["-"] = { "actions.parent", mode = "n" },
      ["_"] = { "actions.open_cwd", mode = "n" },
      ["`"] = { "actions.cd", mode = "n" },
      ["g~"] = { "actions.cd", opts = { scope = "tab" }, mode = "n" },
      ["gs"] = { "actions.change_sort", mode = "n" },
      ["gx"] = "actions.open_external",
      ["g."] = { "actions.toggle_hidden", mode = "n" },
      ["g\\"] = { "actions.toggle_trash", mode = "n" },
    },
    use_default_keymaps = true,
    view_options = {
      show_hidden = true,
      is_hidden_file = function(name, bufnr)
        local m = name:match("^%.")
        return m ~= nil
      end,
      is_always_hidden = function(name, bufnr)
        return false
      end,
      natural_order = "fast",
      case_insensitive = false,
      sort = {
        { "type", "asc" },
        { "name", "asc" },
      },
      highlight_filename = function(entry, is_hidden, is_link_target, is_link_orphan)
        return nil
      end,
    },
    extra_scp_args = {},
    extra_s3_args = {},
    git = {
      add = function(path)
        return false
      end,
      mv = function(src_path, dest_path)
        return false
      end,
      rm = function(path)
        return false
      end,
    },
    float = {
      padding = 2,
      max_width = 0,
      max_height = 0,
      border = nil,
      win_options = {
        winblend = 0,
      },
      get_win_title = nil,
      preview_split = "right",
      override = function(conf)
        return conf
      end,
    },
    preview_win = {
      update_on_cursor_moved = true,
      preview_method = "fast_scratch",
      disable_preview = function(filename)
        return false
      end,
      win_options = {},
    },
    confirmation = {
      max_width = 0.9,
      min_width = { 40, 0.4 },
      width = nil,
      max_height = 0.9,
      min_height = { 5, 0.1 },
      height = nil,
      border = nil,
      win_options = {
        winblend = 0,
      },
    },
    progress = {
      max_width = 0.9,
      min_width = { 40, 0.4 },
      width = nil,
      max_height = { 10, 0.9 },
      min_height = { 5, 0.1 },
      height = nil,
      border = nil,
      minimized_border = "none",
      win_options = {
        winblend = 0,
      },
    },
    ssh = {
      border = nil,
    },
    keymaps_help = {
      border = nil,
    },
  })

  ensure_oil_loaded = function() end
end

local function is_directory_buffer(bufnr)
  local name = vim.api.nvim_buf_get_name(bufnr)
  if name == "" then
    return false
  end

  local stat = vim.uv.fs_stat(name)
  return stat and stat.type == "directory" or false
end

vim.api.nvim_create_autocmd("BufEnter", {
  group = vim.api.nvim_create_augroup("plugins.oil.lazy", { clear = true }),
  callback = function(args)
    if is_directory_buffer(args.buf) then
      ensure_oil_loaded()
    end
  end,
})

if is_directory_buffer(vim.api.nvim_get_current_buf()) then
  ensure_oil_loaded()
end

vim.keymap.set("n", "<leader>n", function()
  ensure_oil_loaded()
  require("oil").toggle_float()
end, { noremap = true, silent = true })

-- vim.api.nvim_set_keymap(
--   "n",
--   "<leader>n",
--   "<cmd>lua require('oil').toggle_float(nil, {preview = {vertical = true}})<CR>",
--   { noremap = true, silent = true }
-- )
