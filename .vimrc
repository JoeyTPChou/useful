" All system-wide defaults are set in $VIMRUNTIME/debian.vim (usually just
" /usr/share/vim/vimcurrent/debian.vim) and sourced by the call to :runtime
" you can find below.  If you wish to change any of those settings, you should
" do it in this file (/etc/vim/vimrc), since debian.vim will be overwritten
" everytime an upgrade of the vim packages is performed.  It is recommended to
" make changes after sourcing debian.vim since it alters the value of the
" 'compatible' option.

" This line should not be removed as it ensures that various options are
" properly set to work with the Vim-related packages available in Debian.
runtime! debian.vim

" Uncomment the next line to make Vim more Vi-compatible
" NOTE: debian.vim sets 'nocompatible'.  Setting 'compatible' changes numerous
" options, so any other options should be set AFTER setting 'compatible'.
"set compatible

" Vim5 and later versions support syntax highlighting. Uncommenting the next
" line enables syntax highlighting by default.
if has("syntax")
  syntax on
endif

" If using a dark background within the editing area and syntax highlighting
" turn on this option as well
"set background=dark

" Uncomment the following to have Vim jump to the last position when
" reopening a file
"if has("autocmd")
"  au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
"endif

" Uncomment the following to have Vim load indentation rules and plugins
" according to the detected filetype.
"if has("autocmd")
"  filetype plugin indent on
"endif

" The following are commented out as they cause vim to behave a lot
" differently from regular Vi. They are highly recommended though.
"set showcmd		" Show (partial) command in status line.
"set showmatch		" Show matching brackets.
"set ignorecase		" Do case insensitive matching
"set smartcase		" Do smart case matching
"set incsearch		" Incremental search
"set autowrite		" Automatically save before commands like :next and :make
"set hidden             " Hide buffers when they are abandoned
"set mouse=a		" Enable mouse usage (all modes)

" Source a global configuration file if available
if filereadable("/etc/vim/vimrc.local")
  source /etc/vim/vimrc.local
endif

syntax on
set shiftwidth=4
set softtabstop=4
set cursorline
set cursorcolumn
set nu
set hls
set cindent
set autoindent
set expandtab
"set noexpandtab

map ,* *<C-O>:%s///gn<CR>
map <F2> :let @/='\<<C-R>=expand("<cword>")<CR>\>'<CR>:set hls<CR>
map <F3> :bprev<CR>
map <F4> :bnext<CR>
map <F5> :e<CR>
map <F6> 1@q
map <F7> :windo set invnumber<CR>
map <F8> :if exists("g:syntax_on") <Bar>
      \   syntax off <Bar>
      \ else <Bar>
      \   syntax enable <Bar>
      \ endif <CR>
map <F9> <leader>ac
map <F10> vipga= 
map <F12> oimport ipdb; ipdb.set_trace(context=30)<ESC>0w
map <C-F7> :set listchars+=space:.<CR>:windo set invlist<CR>

"set encoding=big5
"set fileencoding=big5
"set termencoding=big5
"set fileencodings=big5,utf-8,euc-jp,gbk,euc-kr,utf-bom,iso8859-1
"set ambiwidth=double

"let g:acp_completeOption = '.,w,b,u,t,i,k'
"hi Pmenu ctermbg=darkyellow ctermfg=black
"hi PmenuSel ctermbg=DarkGreen ctermfg=black

filetype indent on
"highlight LineNr ctermfg=darkgrey
"colorscheme distinguished 

"filetype plugin indent on
"let c_no_curly_error=1
"au BufNewFile,BufRead *.cpp set syntax=cpp11
"au FileType c,cpp,objc,objcpp call rainbow#load()
"let g:rainbow_active = 1
"let g:rainbow_load_separately = [
"    \ [ '*' , [['(', ')'], ['\[', '\]'], ['{', '}']] ],
"    \ [ '*.tex' , [['(', ')'], ['\[', '\]']] ],
"    \ [ '*.cpp' , [['(', ')'], ['\[', '\]'], ['{', '}']] ],
"    \ [ '*.{html,htm}' , [['(', ')'], ['\[', '\]'], ['{', '}'], ['<\a[^>]*>', '</[^>]*>']] ],
"    \ ]
"
"let g:rainbow_guifgs = ['RoyalBlue3', 'DarkOrange3', 'DarkOrchid3', 'FireBrick']
"let g:rainbow_ctermfgs = ['lightblue', 'lightgreen', 'yellow', 'red', 'magenta']
"set t_Co=256
"colorscheme gruvbox

"let g:solarized_termcolors=256
"syntax enable
""colorscheme solarized
"if has('gui_running')
"  set background=light
"else
"  set background=dark
"endif

execute pathogen#infect()
colorscheme monokai
colorscheme gruvbox 
set background=dark
"au BufNewFile,BufRead *.cpp setlocal ft=cpp14
au BufNewFile,BufRead *.pde setlocal ft=arduino
au BufNewFile,BufRead *.ino setlocal ft=arduino
au BufNewFile,BufRead *.swift setlocal ft=swift
let g:vim_arduino_map_keys = 0
au BufNewFile,BufRead *.txt setlocal ft=conf
au BufNewFile,BufRead *.launch set filetype=xml
set cinoptions=l1
set nowrap

set tags=.tags
set encoding=utf-8
set fileencoding=utf-8

" Highlight 
augroup HiglightTODO
  autocmd!
  autocmd WinEnter,VimEnter * :silent! call matchadd('Todo', 'TODO\|FIXME\|DEBUG\|HACK\|HACK_BEGIN\|HACK_END\|HACK_NOTE', 10)
augroup END

let g:indent_guides_auto_colors = 0
autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd  ctermbg=236
autocmd VimEnter,Colorscheme * :hi IndentGuidesEven ctermbg=237
let g:indent_guides_start_level = 2
let g:indent_guides_guide_size = 1
autocmd BufReadPre,FileReadPre * :IndentGuidesEnable

set synmaxcol=200

nnoremap <C-w>u :source ~/.vim_session<CR>
nnoremap <C-w>s :mksession! ~/.vim_session<CR>
" Specify a directory for plugins
" - For Neovim: ~/.local/share/nvim/plugged
" - Avoid using standard Vim directory names like 'plugin'
call plug#begin('~/.vim/plugged')

" Shorthand notation; fetches https://github.com/junegunn/vim-easy-align
Plug 'junegunn/vim-easy-align'

" Initialize plugin system
call plug#end()

" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)

" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)

" Add cuda syntx to .cu and .cuh "
au BufNewFile,BufRead *.cu set ft=cuda
au BufNewFile,BufRead *.cuh set ft=cuda
let g:syntastic_python_checkers=['mypy']
