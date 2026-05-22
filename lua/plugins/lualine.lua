local setup_lualine

setup_lualine = function()
  vim.pack.add({ 'https://github.com/nvim-tree/nvim-web-devicons' })
  vim.pack.add({ 'https://github.com/nvim-lualine/lualine.nvim' })

  local diagnostics = {
    "diagnostics",
    sources = { "nvim_diagnostic" },
    sections = { "error", "warn" },
    symbols = { error = " ", warn = " " },
    colored = true,
    update_in_insert = false,
    always_visible = true,
    cond = function()
      return vim.bo.filetype ~= "markdown"
    end,
  }

  local diff = {
    "diff",
    colored = true,
    symbols = { added = " ", modified = " ", removed = " " },
  }

  local mode = {
    "mode",
    fmt = function(str)
      return str
    end,
  }

  local progress = function()
    local current_line = vim.fn.line(".")
    local total_lines = vim.fn.line("$")
    local chars = { "", "", "" } --adding more chars will still work
    local line_ratio = current_line / total_lines
    local index = math.ceil(line_ratio * #chars)
    return chars[index] .. " " .. math.floor(line_ratio * 100) .. "%%"
  end

  local theme = require("kanagawa.colors").setup().theme
  local normal_hl = vim.api.nvim_get_hl(0, { name = "Normal", link = false })
  local statusline_bg = normal_hl.bg and string.format("#%06x", normal_hl.bg) or "none"

  local kanagawa = {}

  kanagawa.normal = {
    a = { bg = statusline_bg, fg = theme.syn.fun },
    b = { bg = statusline_bg, fg = theme.ui.fg },
    c = { bg = statusline_bg, fg = theme.ui.fg },
  }

  kanagawa.insert = {
    a = { bg = statusline_bg, fg = theme.diag.ok },
    b = { bg = statusline_bg, fg = theme.ui.fg },
  }

  kanagawa.command = {
    a = { bg = statusline_bg, fg = theme.syn.operator },
    b = { bg = statusline_bg, fg = theme.ui.fg },
  }

  kanagawa.visual = {
    a = { bg = statusline_bg, fg = theme.syn.keyword },
    b = { bg = statusline_bg, fg = theme.ui.fg },
  }

  kanagawa.replace = {
    a = { bg = statusline_bg, fg = theme.syn.constant },
    b = { bg = statusline_bg, fg = theme.ui.fg },
  }

  kanagawa.inactive = {
    a = { bg = statusline_bg, fg = theme.ui.fg_dim },
    b = { bg = statusline_bg, fg = theme.ui.fg_dim, gui = "bold" },
    c = { bg = statusline_bg, fg = theme.ui.fg_dim },
  }

  if vim.g.kanagawa_lualine_bold then
    for _, made in pairs(kanagawa) do
      mode.a.gui = "bold"
    end
  end

  require("lualine").setup({
    options = {
      icons_enabled = true,
      theme = kanagawa,
      globalstatus = true,
      component_separators = { left = "", right = "" },
      section_separators = { left = "", right = "" },
      disabled_filetypes = { "alpha" },
      always_divide_middle = true,
    },
    sections = {
      lualine_a = { mode },
      lualine_b = { "filename" },
      lualine_c = { diff },
      lualine_x = { diagnostics, "filetype", "fileformat" },
      lualine_y = { "location" },
      lualine_z = { progress },
    },
    extensions = { "nvim-tree" },
  })

  setup_lualine = function() end
end

require("lazyload").on_vim_enter(setup_lualine, { sync = true })
