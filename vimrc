"                 o8o
"                 `"'
"    oooo    ooo oooo  ooo. .oo.  .oo.   oooo d8b  .ooooo.
"     `88.  .8'  `888  `888P"Y88bP"Y88b  `888""8P d88' `"Y8
"      `88..8'    888   888   888   888   888     888
".o.    `888'     888   888   888   888   888     888   .o8
"Y8P     `8'     o888o o888o o888o o888o d888b    `Y8bod8P'

" Ctrl-@でペーストモード
set pastetoggle=<C-@>

set encoding=utf-8
scriptencoding utf-8

" English
language C

"行番号・行のライン
set number
set cursorline

"文字コード
set fileencoding=utf-8
scriptencoding utf-8
set ambiwidth=double

"インデント
set smartindent

"サーチ
set incsearch
set ignorecase
set smartcase
set hlsearch
nnoremap <silent><Esc><Esc> :<C-u>set nohlsearch!<CR>

"バッファ
set hidden

"タブの扱い
set tabstop=4
set shiftwidth=4
set softtabstop=0
set expandtab
set smarttab
set shiftround


"for complete
set completeopt+=menuone,menu,preview
set pumheight=12

"Use syntax highlight
syntax enable

"for terminalMod
set splitbelow

"for backspaceKey
set backspace=indent,eol,start

"for command mode
set wildmenu

"window
set noequalalways

"検索件数の表示
set shortmess-=S

"Undoポイントの設置
inoremap <silent><C-w> <C-g>u<C-w>
inoremap <silent><C-u> <C-g>u<C-u>
inoremap <silent><C-m> <C-g>u<C-m>
inoremap <silent><C-j> <C-g>u<C-j>

" Enable mouse
set mouse=a

" jk
nnoremap j gj
nnoremap k gk

" colorscheme
set background=dark
color onedark

"leader key
let mapleader = "\<Space>"

"myKeyMapping
noremap <silent><Leader>f :ALEFix<CR>
noremap <silent><Leader>e :NERDTreeToggle<CR>

"for ale
let g:ale_linters = {
    \ 'python': ['flake8'],
    \   'javascript': ['eslint', 'eslint-plugin-vue'],
    \   'ruby': ['rubocop'],
    \   'tex': ['textlint'],
    \   'markdown': ['textlint'],
    \   'css': ['stylelint'],
    \ }
let g:ale_fixers = {
    \ 'python': ['autopep8', 'isort'],
    \ }
let g:ale_python_flake8_executable = "/usr/bin/env"
let g:ale_python_flake8_options = "python3 -m flake8 --ignore E501"
let g:ale_fix_on_save = 0
let g:ale_sign_column_always = 1

nmap <silent> <C-k> <plug>(ale_previous_wrap)
nmap <silent> <C-j> <Plug>(ale_next_wrap)

let g:quickrun_config = {
    \  'python': {
    \    'command': 'python3'
    \  },
    \}

"for tabpage
" Anywhere SID.
function! s:SID_PREFIX()
  return matchstr(expand('<sfile>'), '<SNR>\d\+_\zeSID_PREFIX$')
endfunction

" Set tabline.
function! s:my_tabline()  "{{{
  let s = ''
  for i in range(1, tabpagenr('$'))
    let bufnrs = tabpagebuflist(i)
    let bufnr = bufnrs[tabpagewinnr(i) - 1]  " first window, first appears
    let no = i  " display 0-origin tabpagenr.
    let mod = getbufvar(bufnr, '&modified') ? '!' : ' '
    let title = fnamemodify(bufname(bufnr), ':t')
    if title == ''
        let title = '[No Name]'
    else
        let title = ' ' . title . ' '
    endif
    let s .= '%'.i.'T'
    let s .= '%#' . (i == tabpagenr() ? 'TabLineSel' : 'TabLine') . '#'
    let s .= ' ' . no . ':' . title
    let s .= mod
    let s .= '%#TabLineFill# '
  endfor
  let s .= '%#TabLineFill#%T%=%#TabLine#'
  return s
endfunction "}}}
let &tabline = '%!'. s:SID_PREFIX() . 'my_tabline()'
set showtabline=2 " 常にタブラインを表示

" The prefix key.
nnoremap    [Tag]   <Nop>
nmap    <leader> [Tag]
" Tab jump
for n in range(1, 9)
  execute 'nnoremap <silent> [Tag]'.n  ':<C-u>tabnext'.n.'<CR>'
endfor
" t1 で1番左のタブ、t2 で1番左から2番目のタブにジャンプ

map <silent> [Tag]t :tablast <bar> tabnew<CR>
" <Leader>t 新しいタブを一番右に作る
map <silent> [Tag]w :tabclose<CR>
" <Leader>x タブを閉じる
map <silent> [Tag]l :tabnext<CR>
" <Leader>n 次のタブ
map <silent> [Tag]h :tabprevious<CR>
" <Leader>p 前のタブ
hi TabLineFill ctermbg=235
hi TabLine ctermbg=236 ctermfg=145
hi TabLineSel ctermbg=114 ctermfg=235

" statusline
set laststatus=2
set noshowmode
function! SetStatusLine()
  let c = 2
  let mode_name = 'N'
  if mode() =~ 'i'
    let c = 1
    let mode_name = 'I'
  elseif mode() =~ 'n'
    let c = 2
    let mode_name = 'N'
  elseif mode() =~ 'R'
    let c = 3
    let mode_name = 'R'
  elseif mode() =~ 'V'
    let c = 4
    let mode_name = 'V'
  endif
  return '%' . c . '* ' . mode_name . ' %* %<%F%=%m%r %18([%{toupper(&ft)}][%l/%L]%)'
endfunction

hi User1 term=bold ctermfg=235 ctermbg=114
hi User2 term=bold ctermfg=235 ctermbg=39
hi User3 term=bold ctermfg=235 ctermbg=204
hi User4 term=bold ctermfg=235 ctermbg=170

set statusline=%!SetStatusLine()

" for rainbow
let g:rainbow_active = 1

" add my template
let g:sonictemplate_vim_template_dir = [
    \ '~/.vim/template'
    \]

" local setting
if glob("~/.vimrc.local") != ''
    source ~/.vimrc.local
endif
