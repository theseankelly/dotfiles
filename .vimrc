"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Sean Kelly's vimrc configuration
"
" Ideas/settings thanks to:
" - Allan MacGregor
"   (https://github.com/amacgregor/dot-files/blob/master/vimrc)
" - Sidney Liebrand
"   (https://medium.com/@sidneyliebrand/a-collection-of-vim-key-binds-4d227c9a455)
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Use Vim settings, rather than Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible
set encoding=utf8

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Environment
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
if has('win32') || has('win64')
  let g:env = 'WINDOWS'
else
  let g:env = 'LINUX'
endif

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Plugins
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

call plug#begin('$HOME/.vim/plugged')
" General functionality/tools
Plug 'tpope/vim-fugitive'
Plug 'scrooloose/nerdtree'
Plug 'scrooloose/nerdcommenter'
Plug 'majutsushi/tagbar'
Plug 'vim-syntastic/syntastic'
Plug 'ntpeters/vim-better-whitespace'

if (g:env == 'LINUX')
  Plug 'junegunn/fzf', { 'dir': '$HOME/.fzf', 'do': './install --all' }
  Plug 'ycm-core/YouCompleteMe', { 'do': './install.py --clang-completer' }
  Plug 'rdnetto/YCM-Generator', { 'branch': 'stable'}
  Plug 'jeaye/color_coded'
else " WINDOWS
  " Note -- requires FZF be installed via chocolately
  Plug 'junegunn/fzf'
endif
Plug 'junegunn/fzf.vim'

" Markdown
Plug 'reedes/vim-pencil'
Plug 'suan/vim-instant-markdown', {'for': 'markdown'}

" Themes
Plug 'morhetz/gruvbox'

" vim-devicons must be last plugin, per documentation
Plug 'ryanoasis/vim-devicons'
call plug#end()

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" General Configuration
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set nowrap
" Show linenumbers
set number
" Enable highlighting of the current line
set cursorline
" Draw a vertical line on column 80 (for wrapping)
set colorcolumn=80

set splitright

" Always use system clipboard
set clipboard^=unnamed,unnamedplus

" Tab settings
set tabstop=2
set shiftwidth=2
set	expandtab

" Autocomplete settings
set wildmode=longest,list,full
set wildmenu

" Make vimdiff open for write
set noro

" Put backup/swp files in dedicated directory to avoid cluttering projects
set backupdir=$HOME/.vim/backup/
set directory=$HOME/.vim/backup/

" Custom search path for tags
set tags=./tags,./TAGS,tags,TAGS,~/tags

" Use 'elite mode' to disable cursor movement
let g:elite_mode=1

" vim-instant-markdown settings
let g:instant_markdown_autostart = 0
let g:instant_markdown_slow = 1

" vim-pencil settings
let g:pencil#WrapModeDefault = 'hard'
let g:pencil#textwidth = 78
augroup pencil
  autocmd!
  autocmd FileType markdown,mkd call pencil#init()
  autocmd FileType text         call pencil#init()
augroup END

" Enable powerline
" Recommended settings from documentation
set noshowmode
set showtabline=2
set laststatus=2
python3 from powerline.vim import setup as powerline_setup
python3 powerline_setup()
python3 del powerline_setup

"" Recommended Syntastic settings
"set statusline+=%#warningmsg#
"set statusline+=%{SyntasticStatuslineFlag()}
"set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_cpp_config_file = '.syntastic_cpp_config'

" vim-better-whitespace
let g:better_whitespace_enabled = 1
"let g:strip_whitespace_on_save = 1
"let g:strip_whitespace_confirm = 0

" Workaround to enable block cursor on mintty
let &t_ti.="\e[1 q"
let &t_SI.="\e[5 q"
let &t_EI.="\e[1 q"
let &t_te.="\e[0 q"

" Theme and Appearance
set background=dark
set t_Co=256
let g:gruvbox_italic=1
colorscheme gruvbox

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Custom key mappings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Leader Key
let mapleader = ","

" Basic functions
nnoremap <Leader>w :w<CR>

" Navigation
nmap <Up> <Nop>
nmap <Down> <Nop>
nmap <Left> <Nop>
nmap <Right> <Nop>

map $ <Nop>
map ^ <Nop>
map { <Nop>
map } <Nop>

noremap K {
noremap J }
noremap H ^
noremap L $

" Make Y consistent with C and D (c$, d$, y$ instead of c$, d$, yy)
nnoremap Y y$

" Use tab to manage indentation
nmap >> <Nop>
nmap << <Nop>
vmap << <Nop>
vmap >> <Nop>
nnoremap <Tab> >>
nnoremap <S-Tab> <<
vnoremap <Tab> >><Esc>gv
vnoremap <S-Tab> <<<Esc>gv

" Extension bindings
map <Leader>n :NERDTreeToggle<CR>
nnoremap <silent> <Leader>v :NERDTreeFind<CR>
map <Leader>m :TagbarToggle<CR>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Everything below here comes from the default vimrc
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" When started as "evim", evim.vim will already have done these settings.
if v:progname =~? "evim"
  finish
endif

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

if has("vms")
  set nobackup		" do not keep a backup file, use versions instead
else
  set backup		" keep a backup file
endif
set history=50		" keep 50 lines of command line history
set ruler		" show the cursor position all the time
set showcmd		" display incomplete commands
set incsearch		" do incremental searching

" For Win32 GUI: remove 't' flag from 'guioptions': no tearoff menu entries
" let &guioptions = substitute(&guioptions, "t", "", "g")

" Don't use Ex mode, use Q for formatting
map Q gq

" CTRL-U in insert mode deletes a lot.  Use CTRL-G u to first break undo,
" so that you can undo CTRL-U after inserting a line break.
inoremap <C-U> <C-G>u<C-U>

" In many terminal emulators the mouse works just fine, thus enable it.
if has('mouse')
  set mouse=a
endif

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
  syntax on
  set hlsearch
endif

" Only do this part when compiled with support for autocommands.
if has("autocmd")

  " Enable file type detection.
  " Use the default filetype settings, so that mail gets 'tw' set to 72,
  " 'cindent' is on in C files, etc.
  " Also load indent files, to automatically do language-dependent indenting.
  filetype plugin indent on

  " Put these in an autocmd group, so that we can delete them easily.
  augroup vimrcEx
  au!

  " For all text files set 'textwidth' to 78 characters.
  autocmd FileType text setlocal textwidth=78

  " When editing a file, always jump to the last known cursor position.
  " Don't do it when the position is invalid or when inside an event handler
  " (happens when dropping a file on gvim).
  " Also don't do it when the mark is in the first line, that is the default
  " position when opening a file.
  autocmd BufReadPost *
    \ if line("'\"") > 1 && line("'\"") <= line("$") |
    \   exe "normal! g`\"" |
    \ endif

  augroup END

else

  set autoindent		" always set autoindenting on

endif " has("autocmd")

" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
" Only define it when not defined already.
if !exists(":DiffOrig")
  command DiffOrig vert new | set bt=nofile | r # | 0d_ | diffthis
		  \ | wincmd p | diffthis
endif

