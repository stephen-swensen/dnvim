set tabstop=4       " The width of a TAB is set to 4. Still it is a \t. It is just that Vim will interpret it to be having a width of 4.
set shiftwidth=4    " Indents will have a width of 4
set softtabstop=4   " Sets the number of columns for a TAB
set expandtab       " Expand TABs to spaces

set nu " show line numbers
syntax on
colorscheme delek

" leave insert mode quickly on <Esc>
" https://powerline.readthedocs.org/en/latest/tipstricks.html
if ! has('gui_running')
    set ttimeoutlen=10
    augroup FastEscape
        autocmd!
        au InsertEnter * set timeoutlen=0
        au InsertLeave * set timeoutlen=1000
    augroup END
endif

" cursor (show Beam for input mode, and Block for normal mode)
" works for Konsole and iTerm2 only
let &t_SI = "\<Esc>]50;CursorShape=1\x7"
let &t_EI = "\<Esc>]50;CursorShape=0\x7"


call plug#begin('~/.vim/plugged')

Plug 'vim-syntastic/syntastic'
Plug 'scrooloose/nerdtree'
Plug 'tpope/vim-fugitive'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

call plug#end()
