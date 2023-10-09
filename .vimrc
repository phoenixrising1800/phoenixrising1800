" .Vimrc configuration
" Author: Nixy (@phoenixrising1800)

"packloadall " Load all pack plugins in .vim/pack
set nocompatible

" Aesthetic
set encoding=utf-8
set background=dark
set t_Co=256
colorscheme evening "or desert preferably

" Leader
let mapleader = ","

set nowrap        " Do not wrap overflowing lines to next line
set backspace=2   " Backspace deletes like most programs in insert mode
set nobackup
set nowritebackup
set noswapfile    " http://robots.thoughtbot.com/post/18739402579/global-gitignore#comment-458413287
set history=10
set ruler         " show the cursor position all the time
set showcmd       " display incomplete commands
set incsearch     " do incremental searching
set ignorecase
set sidescroll=1  " (For fast terminal), min. # columns to scroll horizontally
set incsearch     " do incremental searching
set ignorecase    " ignore case when performing searches
set laststatus=2  " Always display the status line
set autowrite     " Automatically :write before running commands
set modelines=0   " Disable modelines as a security precaution
set nomodeline
set ttimeoutlen=50 " No pause when leaving insert mode

" Set filetype detection, plugin, and indent settings ON (check w/ :filetype)
filetype plugin indent on

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if (&t_Co > 2 || has("gui_running")) && !exists("syntax_on")
  syntax on
endif

" When the type of shell script is /bin/sh, assume a POSIX-compatible
" shell for syntax highlighting purposes.
let g:is_posix = 1

" Softtabs, 4 spaces
set tabstop=4
set shiftwidth=4
set shiftround
set expandtab

" Display extra whitespace
set list listchars=tab:»·,trail:·,nbsp:·,precedes:<,extends:>

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

" Quick-close and save all buffers
command! WQ execute ':wqall'

"Quick-close all buffers without saving
command! Q execute ':qall'

" Easily close all buffers except the one in current buffer/window (use '[:BufOnly]' command)
command! BufOnly execute '%bdelete|edit #|normal `"'

" Easily reload .vimrc modifications lately saved
command! ReLoad execute 'so %'

" Quickly open all current buffers in vertical panes
command! Vball execute ':vertical ball'

" Save a file easier with leader-w
noremap <leader>w :w<cr>

" List all buffers easier with leader-ls
noremap <leader>ls :ls!<cr>

" Quick split window resizing
nnoremap <special> <leader>< <C-W>5><cr>
nnoremap <special> <leader>> <C-W>5<<cr>
nnoremap <special> <leader>} :exe "res " . (winheight(0) * 3/2)<cr>
nnoremap <special> <leader>{ :exe "res " . (winheight(0) * 2/3)<cr>

" Quicker window movement (only need to hit Ctrl + h/j/k/l)
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-h> <C-w>h
nnoremap <C-l> <C-w>l

" Quickly move window to direction (Ctrl + H/J/K/L)
nnoremap <C-J> <C-w>J
nnoremap <C-K> <C-w>K
nnoremap <C-H> <C-w>H
nnoremap <C-L> <C-w>L

" Map Ctrl + p to open fuzzy find (FZF)
nnoremap <c-p> :Files<cr>

" Always use vertical diffs
set diffopt+=vertical

set mouse=a

" Auto load fold views on buffer start of text file (preserve)
autocmd BufWinLeave *.txt mkview
autocmd BufWinEnter *.txt silent loadview

"" NETRW BROWSER
let g:netrw_liststyle = 1
let g:netrw_banner = 1 "Show Netrw directory menu banner
let g:netrw_browse_split = 4 
let g:netrw_winsize = 40
let g:netrw_altv = 1
let g:netrw_chgwin = -1
let g:netrw_preview = 1
let g:netrw_dirhistmax = 0 "Suppress history launch when vim opens

" On VIM start if given input files, launch Lexplore browser. Else launch regular Explore browser
augroup ProjectDrawer
  autocmd!
  autocmd VimEnter * 
        \ if argc() > 0 | 
          \ :Lexplore | wincmd w | :let g:netrw_chgwin=-1 |
        \ else |
          \ :Explore! | 
        \ endif 
augroup END

" fix netrw_liststyle tree buffer issues
function! WipeBuffer(name, id)
  let buffer_number = bufnr(a:name)
  execute 'bwipeout' buffer_number
endfunction

" Unloads/hides Netrw Explorer window from bufferlist once detected to make things run smoother
augroup WipeNet rw
  autocmd!
  autocmd BufHidden * if &ft == 'netrw' | 
    \ call timer_start(100, function('WipeBuffer', [expand('<afile>')])) | " see: ':help expand'
    \ endif 
augroup END

"" VIM-AIRLINE theme plugin aesthetic options
let g:airline_powerline_fonts = 1
let g:airline_statusline_ontop = 0
let g:airline_section_b = '%{getcwd()}' "secB of status line display CWD

let g:airline#extensions#tabline#enabled = 1 "Enable list of buffers

let g:airline#extensions#tabline#show_tabs = 1          " show tabline
let g:airline#extensions#tabline#show_close_button = 1  " put 'X' at the end of the tabline
let g:airline#extensions#tabline#tabs_label = 't'       " can put text here like BUFFERS to denote buffers 
let g:airline#extensions#tabline#buffers_label = '%'    " can put text here like TABS to denote tabs 
let g:airline#extensions#tabline#fnamemod = ':t'        " disable file paths in the tab
let g:airline#extensions#tabline#show_tab_count = 1     " show tab numbers on the right
let g:airline#extensions#tabline#show_buffers = 1       " show buffers in the tabline
let g:airline#extensions#tabline#tab_min_count = 1      " minimum of 1 tabs needed to display the tabline
let g:airline#extensions#tabline#show_splits = 1        " enables the buffer name that displays on the right of the tabline
let g:airline#extensions#tabline#show_tab_nr = 1        " enable tab numbers
let g:airline#extensions#tabline#show_tab_type = 0      " disables the weird orange arrow on the tabline

let g:airline#extensions#tabline#formatter = 'unique_tail_improved'


"" Current plugins:
" vim-airline (:h vim-airline)
" vim-table-mode (:h table-mode)

" Output the current syntax group (may not work)
nnoremap <f10> :echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<'
\ . synIDattr(synID(line("."),col("."),0),"name") . "> lo<"
\ . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"<cr>

"" SET HIGHLIGHT COLOR FOR GROUPS
" SpecialKeys (like tabs) are greyed out
hi SpecialKey term=NONE ctermfg=grey guifg=grey70
