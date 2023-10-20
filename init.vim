set nocompatible              " be iMproved, required
set autoread
filetype off                  " required

" --------------------------------------------------------------------------------
"               NeoVim Plugin Manager
" --------------------------------------------------------------------------------
"### install the plugin manager with:
"``
"sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       "https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
"```
" then install the plugins in neovim with: 
"                                           :PluginInstall
call plug#begin()
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
"   editor settings
" --------------------------------------------------------------------------------
"
set clipboard=unnamedplus " Enables the clipboard between Vim/Neovim and other applications.
set completeopt=noinsert,menuone,noselect " Modifies the auto-complete menu to behave more like an IDE.
set cursorline " Highlights the current line in the editor
set hidden " Hide unused buffers
set autoindent " Indent a new line
set inccommand=split " Show replacements in a split screen
set mouse=a " Allow to use the mouse in the editor
"set number " Shows the line numbers
set splitbelow splitright " Change the split screen behavior
set title " Show file title
set wildmenu " Show a more advance menu
set cc=80 " Show at 80 column a border for good code style
filetype plugin indent on   " Allow auto-indenting depending on file type
syntax on
"set spell " enable spell check (may need to download language package)
set ttyfast " Speed up scrolling in Vim

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
"      Terminal 
" --------------------------------------------------------------------------------
"
" move out of terminal with leader-w
tnoremap <leader>w <C-\><C-N><C-w><C-w>

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


" open Nerd Tree when there was no file on the command line:
function! StartUp()
    if 0 == argc()
        NERDTree
    end
endfunction

autocmd VimEnter * call StartUp()
