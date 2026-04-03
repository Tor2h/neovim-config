let SessionLoad = 1
let s:so_save = &g:so | let s:siso_save = &g:siso | setg so=0 siso=0 | setl so=-1 siso=-1
let v:this_session=expand("<sfile>:p")
doautoall SessionLoadPre
silent only
silent tabonly
cd ~/.config/nvim
if expand('%') == '' && !&modified && line('$') <= 1 && getline(1) == ''
  let s:wipebuf = bufnr('%')
endif
let s:shortmess_save = &shortmess
set shortmess+=aoO
badd +118 ~/.config/nvim/lua/plugins/snacks.lua
badd +3 ~/.config/nvim/lua/plugins/highlight-colors.lua
badd +1 ~/.config/nvim/lua/plugins/auto-tag.lua
badd +3 ~/.config/nvim/lua/plugins/auto-session.lua
badd +63 ~/.config/nvim/lua/plugins/gitsigns.lua
badd +1 ~/.config/nvim/lua/plugins/db.lua
badd +7 ~/.config/nvim/lua/plugins/global-note.lua
badd +7 ~/.config/nvim/lua/plugins/harpoon.lua
badd +2 ~/.config/nvim/lua/plugins/kanagawa.lua
badd +1 ~/.config/nvim/lua/plugins/mini.lua
badd +32 ~/.config/nvim/lua/plugins/nvim-treesitter.lua
badd +2 ~/.config/nvim/lua/plugins/which-key.lua
badd +1 ~/.config/nvim/nvim-pack-lock.json
badd +3 ~/.config/nvim/lua/config/lsp.lua
badd +1 lua/config/keymap.lua
badd +8 ~/.config/nvim/lua/plugins/lualine.lua
badd +24 ~/.config/nvim/init.lua
badd +3 ~/.config/nvim/lua/plugins/render-markdown.lua
badd +4 ~/Notes/nvim/note.md
badd +24 ~/.config/nvim/lua/plugins/none-ls.lua
badd +8 ~/.config/nvim/lua/config/autocmd.lua
badd +11 ~/.config/nvim/lua/plugins/snippets.lua
badd +4 ~/.config/nvim/lua/plugins/undotree.lua
badd +52 ~/.config/nvim/lsp/svelte.lua
badd +5 ~/.config/nvim/lua/plugins/yanky.lua
badd +7 ~/.config/nvim/lua/plugins/yazi.lua
argglobal
%argdel
edit ~/.config/nvim/lua/plugins/yazi.lua
let s:save_splitbelow = &splitbelow
let s:save_splitright = &splitright
set splitbelow splitright
wincmd _ | wincmd |
split
1wincmd k
wincmd w
let &splitbelow = s:save_splitbelow
let &splitright = s:save_splitright
wincmd t
let s:save_winminheight = &winminheight
let s:save_winminwidth = &winminwidth
set winminheight=0
set winheight=1
set winminwidth=0
set winwidth=1
exe '1resize ' . ((&lines * 21 + 22) / 45)
exe '2resize ' . ((&lines * 21 + 22) / 45)
argglobal
balt ~/.config/nvim/init.lua
setlocal foldmethod=manual
setlocal foldexpr=v:lua.vim.treesitter.foldexpr()
setlocal foldmarker={{{,}}}
setlocal foldignore=#
setlocal foldlevel=0
setlocal foldminlines=1
setlocal foldnestmax=20
setlocal foldenable
silent! normal! zE
let &fdl = &fdl
let s:l = 7 - ((6 * winheight(0) + 10) / 21)
if s:l < 1 | let s:l = 1 | endif
keepjumps exe s:l
normal! zt
keepjumps 7
normal! 088|
wincmd w
argglobal
if bufexists(fnamemodify("~/.config/nvim/lua/plugins/yanky.lua", ":p")) | buffer ~/.config/nvim/lua/plugins/yanky.lua | else | edit ~/.config/nvim/lua/plugins/yanky.lua | endif
if &buftype ==# 'terminal'
  silent file ~/.config/nvim/lua/plugins/yanky.lua
endif
balt lua/config/keymap.lua
setlocal foldmethod=manual
setlocal foldexpr=v:lua.vim.treesitter.foldexpr()
setlocal foldmarker={{{,}}}
setlocal foldignore=#
setlocal foldlevel=0
setlocal foldminlines=1
setlocal foldnestmax=20
setlocal foldenable
silent! normal! zE
let &fdl = &fdl
let s:l = 4 - ((3 * winheight(0) + 10) / 21)
if s:l < 1 | let s:l = 1 | endif
keepjumps exe s:l
normal! zt
keepjumps 4
normal! 0
wincmd w
exe '1resize ' . ((&lines * 21 + 22) / 45)
exe '2resize ' . ((&lines * 21 + 22) / 45)
tabnext 1
if exists('s:wipebuf') && len(win_findbuf(s:wipebuf)) == 0 && getbufvar(s:wipebuf, '&buftype') isnot# 'terminal'
  silent exe 'bwipe ' . s:wipebuf
endif
unlet! s:wipebuf
set winheight=1 winwidth=20
let &shortmess = s:shortmess_save
let &winminheight = s:save_winminheight
let &winminwidth = s:save_winminwidth
let s:sx = expand("<sfile>:p:r")."x.vim"
if filereadable(s:sx)
  exe "source " . fnameescape(s:sx)
endif
let &g:so = s:so_save | let &g:siso = s:siso_save
set hlsearch
nohlsearch
doautoall SessionLoadPost
unlet SessionLoad
" vim: set ft=vim :
