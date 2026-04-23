local M = {}

local function get_tab_filename(tabnr)
  local buflist = vim.fn.tabpagebuflist(tabnr)
  local winnr = vim.fn.tabpagewinnr(tabnr)
  local bufnr = buflist[winnr]
  local name = vim.api.nvim_buf_get_name(bufnr)

  if name == "" then
    return "[No Name]"
  end

  return vim.fn.fnamemodify(name, ":t")
end

function M.render()
  local parts = {}
  local current_tab = vim.fn.tabpagenr()
  local last_tab = vim.fn.tabpagenr("$")

  for tabnr = 1, last_tab do
    local highlight = tabnr == current_tab and "%#TabLineSel#" or "%#TabLine#"
    local label = get_tab_filename(tabnr):gsub("%%", "%%%%")

    parts[#parts + 1] = "%" .. tabnr .. "T"
    parts[#parts + 1] = highlight
    parts[#parts + 1] = " " .. label .. " "
  end

  parts[#parts + 1] = "%#TabLineFill#%T"

  return table.concat(parts)
end

vim.o.tabline = "%!v:lua.require'config.tabline'.render()"

return M
