set nocompatible              " be iMproved, required
set autoread
filetype off                  " required


call plug#begin()
" The default plugin directory will be as follows:
"   - Vim (Linux/macOS): '~/.vim/plugged'
"   - Vim (Windows): '~/vimfiles/plugged'
"   - Neovim (Linux/macOS/Windows): stdpath('data') . '/plugged'
" You can specify a custom plugin directory by passing it as the argument
"   - e.g. `call plug#begin('~/.vim/plugged')`
"   - Avoid using standard Vim directory names like 'plugin'

" Make sure you use single quotes

Plug 'preservim/nerdtree'
Plug 'preservim/nerdcommenter'
Plug 'godlygeek/tabular'
"Plug 'klen/python-mode'
Plug 'preservim/vim-markdown'
Plug 'jupyter-vim/jupyter-vim' 
"Plug 'nvie/vim-flake8'
Plug 'junegunn/goyo.vim'

" Initialize plugin system
" - Automatically executes `filetype plugin indent on` and `syntax enable`.
call plug#end()
" You can revert the settings after the call like so:
"   filetype indent off   " Disable file-type-specific indentation
"   syntax off            " Disable syntax highlighting


" --------------------------------------------------------------------------------
"   configure editor for tabs
" --------------------------------------------------------------------------------
"
" configure expanding of tabs for various file types
au BufRead,BufNewFile *.py set expandtab

set expandtab           " enter spaces when tab is pressed
set tabstop=4           " use 4 spaces to represent tab
set softtabstop=4
set shiftwidth=4        " number of spaces to use for auto indent
set autoindent          " copy indent from current line when starting a new line
" make backspaces more powerfull
set backspace=indent,eol,start

" --------------------------------------------------------------------------------
"       map leader setting
" --------------------------------------------------------------------------------
"
let mapleader = "," 

"
" --------------------------------------------------------------------------------
"       Ipython Qtconsole integration (JupyterVim)
" --------------------------------------------------------------------------------
"
let g:python3_host_prog = '$HOME/miniconda3/bin/python'

nnoremap <buffer> <silent> <leader>x :JupyterSendCell<CR>
nnoremap <buffer> <silent> <leader>r :JupyterRunFile<CR>


"
" --------------------------------------------------------------------------------
"       Buffers
" --------------------------------------------------------------------------------
"
nnoremap <tab><tab>b :bNext<CR>
" Access and shift buffers  (list with F5, shift next with <tab>b
nnoremap <F5> :buffers<CR>:buffer<Space>
nnoremap <tab>b :bNext<CR>
nnoremap <tab><tab>b :bNext<CR>

" --------------------------------------------------------------------------------
"       some other settings: 
" --------------------------------------------------------------------------------
"

" window commands with just <tab> (e.g. <tab>l moves to window on the right)
nnoremap <tab> <C-w>

" having a nice clipboard - yank link
set clipboard=unnamedplus

" open Nerd Tree when there was no file on the command line:
function! StartUp()
    if 0 == argc()
        NERDTree
    end
endfunction

autocmd VimEnter * call StartUp()
