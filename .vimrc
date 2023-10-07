" .Vimrc configuration
" Author: Nixy (@phoenixrising1800)

set nocompatible

" Aesthetic
set encoding=utf-8
set background=dark
set t_Co=256
colorscheme desert

" Leader
let mapleader = ","

set backspace=2   " Backspace deletes like most programs in insert mode
set nobackup
set nowritebackup
set noswapfile    " http://robots.thoughtbot.com/post/18739402579/global-gitignore#comment-458413287
set history=50
set ruler         " show the cursor position all the time
set showcmd       " display incomplete commands
set incsearch     " do incremental searching
set ignorecase
set laststatus=2  " Always display the status line
set autowrite     " Automatically :write before running commands
set modelines=0   " Disable modelines as a security precaution
set nomodeline

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if (&t_Co > 2 || has("gui_running")) && !exists("syntax_on")
  syntax on
endif

filetype plugin indent on

" When the type of shell script is /bin/sh, assume a POSIX-compatible
" shell for syntax highlighting purposes.
let g:is_posix = 1

" Softtabs, 2 spaces
set tabstop=2
set shiftwidth=2
set shiftround
set expandtab

" Display extra whitespace
set list listchars=tab:»·,trail:·,nbsp:·

" Use one space, not two, after punctuation.
set nojoinspaces

" Make it obvious where 80 characters is
set textwidth=80
set colorcolumn=+1

" Numbers
set number
set numberwidth=5

" Finding files
set path+=**
set wildmenu

" Open new split panes to right and bottom, which feels more natural
set splitright
set splitbelow

" Quickly toggle line numbers with leader-n
noremap <leader>n :set number!<cr>

" Save a file easier with leader-w
noremap <leader>w :w<cr>

" Quicker window movement
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-h> <C-w>h
nnoremap <C-l> <C-w>l

" Map Ctrl + p to open fuzzy find (FZF)
nnoremap <c-p> :Files<cr>

" Always use vertical diffs
set diffopt+=vertical

set mouse=a

"" netrw browser
let g:netrw_liststyle = 3
let g:netrw_banner = 0
let g:netrw_browse_split = 4
let g:netrw_winsize = 25
let g:netrw_altv = 1
let g:netrw_preview=1
" launch when vim open
augroup ProjectDrawer
  autocmd!
  autocmd TabNew * :Vexplore
  "old: autocmd VimEnter * :Vexplore | wincmd w " have cursor in file on open
  autocmd VimEnter * |
        \ if argc() >= 1 | 
          \ :Sexplore! | wincmd w | 
        \ elseif argc() == 0 |
          \ :Vexplore | 
        \ endif 
augroup END

"" vim-airline aesthetic options
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#formatter = 'unique_tail_improved'
