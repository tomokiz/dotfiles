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
    \  'enable': { 'tabline': 0 },
    \  'colorscheme': 'wombat',
    \ 'separator': { 'left': " ◣", 'right':"◢" },
    \ 'subseparator': { 'left': "/", 'right': "/" }
    \}

" If have Powerline Font
let exec = system('fc-list | grep Powerline | wc -l')
if exec > 0
    let g:lightline = {
    \  'enable': { 'tabline': 0 },
    \  'colorscheme': 'wombat',
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

" ______  _______ _____ __   _   _    _ _____ _______
" |     \ |______   |   | \  |    \  /    |   |  |  |
" |_____/ |______ __|__ |  \_| .   \/   __|__ |  |  |
"dein Scripts-----------------------------
" dein自体の自動インストール
let s:cache_home = empty($XDG_CACHE_HOME) ? expand('~/.cache') : $XDG_CACHE_HOME
let s:dein_dir = s:cache_home . '/dein'
let s:dein_repo_dir = s:dein_dir . '/repos/github.com/Shougo/dein.vim'
if !isdirectory(s:dein_repo_dir)
  call system('git clone https://github.com/Shougo/dein.vim ' . shellescape(s:dein_repo_dir))
endif
let &runtimepath = s:dein_repo_dir .",". &runtimepath
" Required:
set runtimepath+=/Users/katokota/.vim/./dein/repos/github.com/Shougo/dein.vim
" Required:
if dein#load_state('~/.cache/dein')
    call dein#begin('~/.cache/dein')
   "Let dein manage dein
   " Required:
    call dein#add('~/.cache/dein')
    let g:rc_dir = '~/.vim/deinrc'
    let s:toml      = g:rc_dir . '/dein.toml'
    let s:lazy_toml = g:rc_dir . '/dein_lazy.toml'

    call dein#load_toml(s:toml,      {'lazy': 0})
    call dein#load_toml(s:lazy_toml, {'lazy': 1})
    " Required:
    call dein#end()
    call dein#save_state()
endif
" Required:
filetype plugin indent on
syntax enable
" If you want to install not installed plugins on startup.
if dein#check_install()
    call dein#install()
endif
"End dein Scripts-------------------------
"For dein
function! s:DeinCleanf()
    call map(dein#check_clean(), "delete(v:val, 'rf')")
    call dein#recache_runtimepath()
endfunction

command! DeinCheckInstall call dein#check_install()
command! DeinCheckClean call dein#check_clean()
command! DeinUpdate call dein#update()

" colorscheme
set background=dark
color lucius

"vim 起動時に実行される
if has('vim_starting')
    "ターミナルを起動し、上画面に移動
    bo terminal ++close ++rows=7
    wincmd k
endif

function! CreateBufnr2tabnrDict() abort
  let bufnr2tabnr_dict = {}
  for tnr in range(1, tabpagenr('$'))
    for bnr in tabpagebuflist(tnr)
      let bufnr2tabnr_dict[bnr] = has_key(bufnr2tabnr_dict, bnr) ? add(bufnr2tabnr_dict[bnr], tnr) : [tnr]
    endfor
  endfor
  for val in values(bufnr2tabnr_dict)
    call uniq(sort(val))
  endfor
  return bufnr2tabnr_dict
endfunction

function! Bufnr2tabnr(bnr) abort
  return CreateBufnr2tabnrDict()[a:bnr]
endfunction

function! ExitTerm()
    if !empty(term_list())
        let term_tabnr = Bufnr2tabnr(term_list()[0])
        let num_win_in_tabnr = tabpagewinnr(term_tabnr[0], '$')
        if num_win_in_tabnr == 1
            q!
            bo terminal ++close ++rows=7
            wincmd k
        endif
    endif
endfunction

augroup term-exit
  autocmd!
  autocmd BufEnter * call ExitTerm()
augroup END

