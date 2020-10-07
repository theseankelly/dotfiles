"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Sean Kelly's vimrc configuration
"
" Ideas/settings thanks to:
" - Allan MacGregor
"   (https://github.com/amacgregor/dot-files/blob/master/vimrc)
" - Sidney Liebrand
"   (https://medium.com/@sidneyliebrand/a-collection-of-vim-key-binds-4d227c9a455)
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

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
" Use vim-sensible for defaults
Plug 'tpope/vim-sensible'
" General functionality/tools
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-vinegar'
Plug 'scrooloose/nerdcommenter'
Plug 'majutsushi/tagbar'
Plug 'vim-syntastic/syntastic'
Plug 'ntpeters/vim-better-whitespace'
Plug 'tmux-plugins/vim-tmux-focus-events'

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

" Themes
Plug 'morhetz/gruvbox'

call plug#end()

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" General Configuration
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set nowrap
" Show linenumbers
set number
set relativenumber
augroup toggle_relative_number
autocmd InsertEnter * :setlocal norelativenumber
autocmd InsertLeave * :setlocal relativenumber
" Enable highlighting of the current line
set cursorline
" Draw a vertical line on column 80 (for wrapping)
set colorcolumn=80

set splitright

set autoread

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
set backupdir=$HOME/.vim/backup//
set directory=$HOME/.vim/swp//

" Custom search path for tags
set tags=./tags,./TAGS,tags,TAGS,~/tags

" Enable powerline
" Recommended settings from documentation
set noshowmode
set showtabline=2
set laststatus=2
python3 from powerline.vim import setup as powerline_setup
python3 powerline_setup()
python3 del powerline_setup

" FZF

" Prevent fzf from searching on the filename returned by rg
" Thanks to https://github.com/junegunn/fzf.vim/issues/346#issuecomment-518087788
" Also add preview window, thanks to https://github.com/junegunn/fzf.vim/issues/676#issuecomment-407964464
command! -bang -nargs=* Rg
  \ call fzf#vim#grep(
  \   "rg --column --line-number --no-heading --color=always --smart-case ".shellescape(<q-args>),
  \   0,
  \   fzf#vim#with_preview({'options': '--delimiter : --nth 4..'}), <bang>0)

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
let g:strip_whitespace_on_save = 1
let g:strip_whitespace_confirm = 0
let g:strip_only_modified_lines = 1

" YouCompleteMe
let g:ycm_confirm_extra_conf = 0
let g:ycm_autoclose_preview_windows_after_insertion = 1

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
let mapleader = "\<Space>"

nnoremap <Leader>s :%s/\<<C-r><C-w>\>//g<Left><Left>

" Edit/reload vimrc
nnoremap <Leader>ve :e $MYVIMRC<CR>
nnoremap <Leader>vr :source $MYVIMRC<CR>


" Basic functions
nnoremap <Leader>w :w<CR>
nnoremap <Leader>q :q<CR>

noremap K {
noremap J }
noremap H ^
noremap L $

nnoremap <C-h> <C-W><C-h>
nnoremap <C-j> <C-W><C-j>
nnoremap <C-k> <C-W><C-k>
nnoremap <C-l> <C-W><C-l>

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
nnoremap <Leader>m :TagbarToggle<CR>
nnoremap <leader>p :Files<CR>
nnoremap <leader>f :Rg<CR>

