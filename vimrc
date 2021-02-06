"                 o8o
"                 `"'
"    oooo    ooo oooo  ooo. .oo.  .oo.   oooo d8b  .ooooo.
"     `88.  .8'  `888  `888P"Y88bP"Y88b  `888""8P d88' `"Y8
"      `88..8'    888   888   888   888   888     888
".o.    `888'     888   888   888   888   888     888   .o8
"Y8P     `8'     o888o o888o o888o o888o d888b    `Y8bod8P'

" ステータスライン設定
let s:winfont = 'Ricty for Powerline:h12'
let g:lightline = {
    \ 'active': {
    \   'left': [ [ 'mode', 'paste' ],
    \             [ 'readonly', 'filename', 'modified' ],
    \             [ 'linter_checking', 'linter_errors', 'linter_warnings' ] ],
    \ },
    \  'enable': { 'tabline': 0 },
    \  'colorscheme': 'onedark',
    \ 'separator': { 'left': " ◣", 'right':"◢" },
    \ 'subseparator': { 'left': "/", 'right': "/" }
    \}

" If have Powerline Font
let exec0 = system('echo $TERMEMU | grep -i haspowerline | wc -l')
if exec0 != 0
    let g:lightline = {
    \ 'active': {
    \   'left': [ [ 'mode', 'paste' ],
    \             [ 'readonly', 'filename', 'modified' ],
    \             [ 'linter_checking', 'linter_errors', 'linter_warnings' ] ],
    \ },
    \  'enable': { 'tabline': 0 },
    \  'colorscheme': 'onedark',
    \ 'separator': { 'left': "\u2b80", 'right':"\u2b82" },
    \ 'subseparator': { 'left': "\u2b81", 'right': "\u2b83" }
    \}
endif

" Ctrl-@でペーストモード
set pastetoggle=<C-@>

set encoding=utf-8
scriptencoding utf-8

" English
language C

"行番号・行のライン
set number
set cursorline

" ステータスライン
set laststatus=2
set noshowmode

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

"vim 起動時に実行される
"if has('vim_starting')
"    "ターミナルを起動し、上画面に移動
"    bo terminal ++close ++rows=7
"    wincmd k
"endif
"
"function! CreateBufnr2tabnrDict() abort
"  let bufnr2tabnr_dict = {}
"  for tnr in range(1, tabpagenr('$'))
"    for bnr in tabpagebuflist(tnr)
"      let bufnr2tabnr_dict[bnr] = has_key(bufnr2tabnr_dict, bnr) ? add(bufnr2tabnr_dict[bnr], tnr) : [tnr]
"    endfor
"  endfor
"  for val in values(bufnr2tabnr_dict)
"    call uniq(sort(val))
"  endfor
"  return bufnr2tabnr_dict
"endfunction
"
"function! Bufnr2tabnr(bnr) abort
"  return CreateBufnr2tabnrDict()[a:bnr]
"endfunction
"
"function! ExitTerm()
"    if !empty(term_list())
"        let term_tabnr = Bufnr2tabnr(term_list()[0])
"        let num_win_in_tabnr = tabpagewinnr(term_tabnr[0], '$')
"        if num_win_in_tabnr == 1
"            q!
"            bo terminal ++close ++rows=7
"            wincmd k
"        endif
"    endif
"endfunction
"
"augroup term-exit
"  autocmd!
"  autocmd BufEnter * call ExitTerm()
"augroup END

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

let g:lightline.component_expand = {
      \  'linter_checking': 'lightline#ale#checking',
      \  'linter_warnings': 'lightline#ale#warnings',
      \  'linter_errors': 'lightline#ale#errors',
      \ }
let g:lightline.component_type = {
      \     'linter_checking': 'left',
      \     'linter_warnings': 'warning',
      \     'linter_errors': 'error',
      \ }
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

" local setting
if glob("~/.vimrc.local") != ''
    source ~/.vimrc.local
endif
