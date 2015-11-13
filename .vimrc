set nocompatible              " be iMproved, required
filetype off                  " required

" === Plugins === {{{

	" set the runtime path to include Vundle and initialize
	set rtp+=~/.vim/bundle/Vundle.vim
	call vundle#begin()
	" alternatively, pass a path where Vundle should install plugins
	"call vundle#begin('~/some/path/here')

	" let Vundle manage Vundle, required
	Plugin 'gmarik/Vundle.vim'
	Plugin 'Shougo/vimproc'
	Plugin 'Shougo/unite.vim'
	Plugin 'Valloric/YouCompleteMe'
	Plugin 'shawncplus/phpcomplete.vim'
	Plugin 'bronson/vim-trailing-whitespace'
	Plugin 'bling/vim-airline'
	Plugin 'airblade/vim-gitgutter'
	Plugin 'tpope/vim-fugitive'
	Plugin 'altercation/vim-colors-solarized.git'
	Plugin 'sickill/vim-pasta'
	Plugin 'chriskempson/base16-vim'
	Plugin 'scrooloose/syntastic'
	Plugin 'alvan/vim-php-manual'
	Plugin 'argtextobj.vim'

	" All of your Plugins must be added before the following line
	call vundle#end()            " required
" }}}

" reset to vim-defaults
if &compatible          " only if not set before:
  set nocompatible      " use vim-defaults instead of vi-defaults (easier, more user friendly)
endif

" temporary files
set directory=~/tmp//,.,/var/tmp//,/tmp//

" use space as leader
let mapleader = " "
let maplocalleader = "\\"

" quick edit vimrc
nnoremap <leader>ev :tabe $MYVIMRC<cr>
nnoremap <leader>sv :source $MYVIMRC<cr>

" tab navigation
nnoremap <S-Left> :tabprevious<CR>
nnoremap <S-Right> :tabnext<CR>
nnoremap <C-t> :tabnew<CR>

" display settings
" set nowrap              " dont wrap lines
set scrolloff=2         " 2 lines above/below cursor when scrolling
set number              " show line numbers
set showmatch           " show matching bracket (briefly jump)
set showmode            " show mode in status bar (insert/replace/...)
set showcmd             " show typed command in status bar
set ruler               " show cursor position in status bar
set title               " show file in titlebar
set wildmenu            " completion with menu
set complete-=i			" do not scan files for completion, use tags
set wildignore=*.o,*.obj,*.bak,*.exe,*.py[co],*.swp,*~,*.pyc,.svn
set laststatus=2        " use 2 lines for the status bar
set matchtime=2         " show matching bracket for 0.2 seconds
set matchpairs+=<:>     " specially for html
set cursorline          " highlight current line

" editor settings
set esckeys             " map missed escape sequences (enables keypad keys)
set ignorecase          " case insensitive searching
set smartcase           " but become case sensitive if you type uppercase characters
set smartindent         " smart auto indenting
set smarttab            " smart tab handling for indenting
set magic               " change the way backslashes are used in search patterns
set bs=indent,eol,start " Allow backspacing over everything in insert mode

set tabstop=4           " number of spaces a tab counts for
set shiftwidth=4        " spaces for autoindents
"set expandtab           " turn a tabs into spaces

set splitright          " open vertical splits to the right
set splitbelow          " open splits to the bottom

set fileformat=unix     " file mode is unix
"set fileformats=unix,dos    " only detect unix file format, displays that ^M with dos files
set modeline

" system settings
set lazyredraw          " no redraws in macros
"set confirm             " get a dialog when :q, :w, or :wq fails
set nobackup            " no backup~ files.
set noswapfile          " no swap files either
set viminfo='20,\"500   " remember copy registers after quitting in the .viminfo file -- 20 jump links, regs up to 500 lines'
set hidden              " remember undo after quitting
set history=100         " keep 100 lines of command history
set undolevels=1000     " keep file history
if v:version >= 730
    set undofile                " keep a persistent backup file
    set undodir=~/.vim/.undo,~/tmp,/tmp
endif
set mouse=v             " use mouse in visual mode (not normal,insert,command,help mode


" color settings (if terminal/gui supports it)
if &t_Co > 2 || has("gui_running")
  syntax on          " enable colors
  set hlsearch       " highlight search (very useful!)
  set incsearch      " search incremently (search while typing)
endif

" http://snk.tuxfamily.org/log/vim-256color-bce.html
" Disable Background Color Erase (BCE) so that color schemes
" work properly when Vim is used inside tmux and GNU screen.
if &term =~ '256color'
  set t_ut=
endif

" paste mode toggle (needed when using autoindent/smartindent)
map <F10> :set paste<CR>
map <F11> :set nopaste<CR>
imap <F10> <C-O>:set paste<CR>
imap <F11> <nop>
set pastetoggle=<F11>

" Use of the filetype plugins, auto completion and indentation support
filetype plugin indent on

" Easy switching in split screens
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" expand %% to the current dir
cabbr <expr> %% expand('%:p:h')

" insert mode abbreviations
iabbrev <? <?php
iabbrev cc company
iabbrev CC Company

nnoremap <Leader>/ :nohlsearch<CR>
nnoremap <Leader>e :lnext<CR>
nnoremap <Leader>E :lprev<CR>

" use hjkl fool
noremap <Up> <NOP>
noremap <Down> <NOP>
noremap <Left> <NOP>
noremap <Right> <NOP>
inoremap <Up> <NOP>
inoremap <Down> <NOP>
inoremap <Left> <NOP>
inoremap <Right> <NOP>

" ESC is so far away
inoremap jk <ESC>
inoremap <esc> <nop>

" Save whenever switching windows or leaving vim. This is useful when running
" the tests inside vim without having to save all files first.
au FocusLost,WinLeave * :silent! wa
" Trigger autoread when changing buffers or coming back to vim.
au FocusGained,BufEnter * :silent! !

"autocmd BufWritePost * !python ~/commands/filewrite.py <afile>:p

autocmd BufRead,BufNewFile *.twig set filetype=html
autocmd BufRead,BufNewFile *.blade.php set filetype=html
autocmd BufRead,BufNewFile /Library/WebServer/* setlocal expandtab

" Commenting blocks of code.
autocmd FileType c,javascript,php let b:comment_leader = '// '
autocmd FileType sh,ruby,python   let b:comment_leader = '# '
autocmd FileType tex              let b:comment_leader = '% '
autocmd FileType vim              let b:comment_leader = '" '
noremap <silent> <leader>c :<C-B>silent <C-E>s/^/<C-R>=escape(b:comment_leader,'\/')<CR>/<CR>:nohlsearch<CR>
noremap <silent> <leader>x :<C-B>silent <C-E>s/^\V<C-R>=escape(b:comment_leader,'\/')<CR>//e<CR>:nohlsearch<CR>

" Unite stuff
nnoremap <Leader><Leader> :<C-u>Unite -start-insert file_rec/async<cr>
nnoremap <Leader>r <Plug>(unite_restart)
let g:unite_source_rec_async_command= 'ag --nocolor --nogroup --hidden -g ""'

let g:ycm_collect_identifiers_from_tags_files = 1
let g:ycm_seed_identifiers_with_syntax = 1
let g:ycm_autoclose_preview_window_after_completion = 1
set completeopt-=preview

" coloring
set background=dark
colorscheme base16-railscasts
highlight clear SignColumn
highlight VertSplit    ctermbg=236
highlight ColorColumn  ctermbg=237
highlight LineNr       ctermbg=236 ctermfg=240
highlight CursorLineNr ctermbg=236 ctermfg=240
highlight CursorLine   ctermbg=236
highlight StatusLineNC ctermbg=238 ctermfg=0
highlight StatusLine   ctermbg=240 ctermfg=12
highlight IncSearch    ctermbg=3   ctermfg=1
highlight Search       ctermbg=1   ctermfg=3
highlight Visual       ctermbg=3   ctermfg=0
highlight Pmenu        ctermbg=240 ctermfg=12
highlight PmenuSel     ctermbg=3   ctermfg=1
highlight SpellBad     ctermbg=0   ctermfg=1

" syntastic
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

" airline
function! AirlineInit()
	let g:airline_section_b = airline#section#create_left(['branch'])
endfunction
autocmd VimEnter * call AirlineInit()


autocmd User fugitive 
  \ if fugitive#buffer().type() =~# '^\%(tree\|blob\)$' |
  \   nnoremap <buffer> <leader>p :edit %:h<CR> |
  \ endif

nnoremap [q :cprev
nnoremap ]q :cnext
nnoremap [Q :cfirst
nnoremap ]Q :clast

" use system clipboard
set clipboard=unnamed
"
" argtextobj
let g:argumentobject_force_toplevel = 1

" CYGWIN cursor fix
let &t_ti.="\e[1 q"
let &t_SI.="\e[5 q"
let &t_EI.="\e[1 q"
let &t_te.="\e[0 q"
