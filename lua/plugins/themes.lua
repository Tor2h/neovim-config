vim.pack.add({ { src = 'https://github.com/rose-pine/neovim', as = 'rose-pine' } })
-- require('rose-pine').setup({})
vim.pack.add({ 'https://github.com/vague-theme/vague.nvim' })
vim.pack.add({ 'https://github.com/sainnhe/everforest' })
vim.pack.add({ { src = 'https://github.com/ember-theme/nvim', as = 'ember' } })

local black_background_themes = { 'rose-pine', 'vague', 'everforest', 'ember' }
local black_background_groups = {
  'Normal',
  'NormalNC',
  'SignColumn',
  'EndOfBuffer',
  'LineNr',
  'CursorLineNr',
  'FoldColumn',
  'NormalFloat',
  'FloatBorder',
  'StatusLine',
  'StatusLineNC',
  'WinSeparator',
}

local function apply_black_background()
  for _, group in ipairs(black_background_groups) do
    vim.api.nvim_set_hl(0, group, { bg = '#000000' })
  end
end

local theme_background_group = vim.api.nvim_create_augroup('ThemeBlackBackground', { clear = true })

vim.api.nvim_create_autocmd('ColorScheme', {
  group = theme_background_group,
  pattern = black_background_themes,
  callback = apply_black_background,
})

if vim.tbl_contains(black_background_themes, vim.g.colors_name) then
  apply_black_background()
end
