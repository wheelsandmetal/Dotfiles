" vim:fdm=marker
" test

" Vundle Setting {{{

set nocompatible
filetype off

set rtp+=~/.vim/plugged
call plug#begin()

Plug 'scrooloose/nerdtree'
Plug 'https://github.com/ctrlpvim/ctrlp.vim'
"" Plug 'Raimondi/delimitMate'
"" Plug 'mhinz/vim-startify'
"" Plugin 'godlygeek/tabular'

call plug#end()            " required
filetype plugin on
filetype plugin indent on    " required


" Automatic reloading of .vimrc
aug reload_vimrc
    au!
    au bufwritepost $MYVIMRC :source $MYVIMRC
aug END

" }}}
"Look and Feel {{{


" Show whitespace
" MUST be inserted BEFORE the colorscheme command


" Color scheme
colo desert
syntax on


" Enable syntax highlighting
" You need to reload this file for the change to apply


" Showing line numbers and length
set number  " show line numbers
set tw=79   " width of document (used by gd)
set nowrap  " don't automatically wrap on load
set fo-=t   " don't automatically wrap text when typing
set colorcolumn=80
highlight ColorColumn ctermbg=233

" Airline Theme {{{
" let g:airline_theme='solarized'

" use powerline fonts for airline (this font must be set in terminal)
" let g:airline_powerline_fonts = 1

" empty airline_symbols
" if !exists('g:airline_symbols')
    " let g:airline_symbols = {}
" endif

" add unicode symbols to airline
" let g:airline_left_sep = '»'
" let g:airline_left_sep = '▶'
" let g:airline_right_sep = '«'
" let g:airline_right_sep = '◀'
" let g:airline_symbols.linenr = '␊'
" let g:airline_symbols.linenr = '␤'
" let g:airline_symbols.linenr = '¶'
" let g:airline_symbols.branch = '⎇'
" let g:airline_symbols.paste = 'ρ'
" let g:airline_symbols.paste = 'Þ'
" let g:airline_symbols.paste = '∥'
" let g:airline_symbols.whitespace = 'Ξ'

" add powerline symbols to airline
" let g:airline_left_sep = ''
" let g:airline_left_alt_sep = ''
" let g:airline_right_sep = ''
" let g:airline_right_alt_sep = ''
" let g:airline_symbols.branch = ''
" let g:airline_symbols.readonly = ''
" let g:airline_symbols.linenr = ''

" Remove '--Insert--, etc...' from under airline
" set noshowmode

" }}}

" Increase Scroll Speed of <c-y> and <c-e>


 " Status line settings
set laststatus=2
set statusline=%f " shortend current file path
set statusline+=%m " is current file modified
set statusline+=%= " switch sies
set statusline+=%.20{getcwd()} " current working dir limited to 20char


" }}}
" Tests {{{


" }}}
" Abbreviations {{{


:iabbrev @@ jakob@schmutz.co.uk


" }}}
" Bindings {{{

" Exit normal mode
inoremap jj <esc>

" Rebind <Leader> key
let mapleader = " "

" Leader Bindings {{{


" Quickly open .vimrc
nnoremap <leader>v :tabnew $MYVIMRC<cr>

" Quick quit command
noremap <Leader>e :q<CR>  " Quit current window
noremap <Leader>E :qa!<CR>   " Quit all windows

" Quick save command
noremap <leader>w :w<cr>

"Quick tab movement
noremap <leader>n :tabprevious<cr>
noremap <leader>m :tabnext<cr>

" Quick sort
vnoremap <Leader>s :sort<CR>

" }}}

" Map : to ;
nnoremap ; :

" Super easy split management
" Fuction to check if a split exits in a given direction and open one if not
function! SelectorOpenNewSplit(key, cmd)
    let current_window = winnr()
    execute 'wincmd' a:key
    if current_window == winnr()
        execute a:cmd
        execute 'wincmd' a:key
    endif
endfunction

" Call the fuction bound to control movent keys
nnoremap <silent> <c-k> :call SelectorOpenNewSplit('k', 'leftabove split')<cr>
nnoremap <silent> <c-j> :call SelectorOpenNewSplit('j', 'leftabove split')<cr>
nnoremap <silent> <c-h> :call SelectorOpenNewSplit('h', 'leftabove vsplit')<cr>
nnoremap <silent> <c-l> :call SelectorOpenNewSplit('l', 'leftabove vsplit')<cr>

" Bind no highlight
" Removes highlight of your last search
nnoremap <C-n> :nohl<CR>

" Easier moving of code blocks
vnoremap < <gv  "" better indentation
vnoremap > >gv  "" better indentation


" }}}
" General Settings {{{


" Better copy & paste
set pastetoggle=<F2>
set clipboard=unnamed

" Real programmers don't use TABs but spaces
set tabstop=4
set softtabstop=4
set shiftwidth=4
set shiftround
set expandtab

" Make search case insensitive
set hlsearch
set incsearch
set ignorecase
set smartcase

" Disable stupid backup and swap files - they trigger too many events
" for file system watchers
set nobackup
set nowritebackup
set noswapfile

" Function to allow keyboard inputs in keybindings
function! KeyboardInput()
    call inputsave()
    let replacement = input('Enter input:')
    call inputrestore()
    execute '%s//'.replacement.'/g'
endfunction

" Better navigating through omnicomplete option list
" See http://stackoverflow.com/questions/2170023/how-to-map-keys-for-popup-menu-in-vim
set completeopt=longest,menuone
function! OmniPopup(action)
    if pumvisible()
        if a:action == 'j'
            return "\<C-N>"
        elseif a:action == 'k'
            return "\<C-P>"
        endif
    endif
    return a:action
endfunction

inoremap <silent><C-j> <C-R>=OmniPopup('j')<CR>
inoremap <silent><C-k> <C-R>=OmniPopup('k')<CR>


" }}}
" Plugin Settings {{{


" Nerd Tree {{{


" Open root dictionary
nnoremap <leader>t :NERDTree ~/<cr>
nnoremap <leader>r :NERDTreeFind<cr>


" }}}


" }}}
" Python Settings {{{


" Run python script
aug runscript
    au!
    au FileType python nnoremap <silent><F5> :w!<cr>:!python3 %<cr>
aug END


" }}}
" Octave Setttings {{{


" .m files are "octave" files
aug detect_octave_files
    au!
    au BufRead,BufNewFile *.m, set filetype=octave
aug END

" F5 will execute the octave script
aug execute_script
    au!
    au filetype octave map <buffer> <f5> gg0pkg load all<esc>Gopause<esc>:w<cr>:!octave -qf %<cr>ddggdd:w<cr>
aug END


" }}}
" LeTeX Settings {{{


let g:tex_flavor = "latex"
set suffixes+=.log,.aux,.bbl,.blg,.idx,.ilg,.ind,.out,.pdf

" Grepprg functionality needed for completion
set grepprg=gre\ -nh\ $*

" Spell check in .tex files
aug spell_checkTeX
    au!
    au BufRead,BufNewFile *.tex setlocal spell
aug END


" }}}
" Java Settings {{{

" Compile code
aug compiling
    au!
    au FileType java nnoremap <F5> :w!<cr>:!javac %<cr>
    au FileType java nnoremap <F6> :! javac %:r<cr>
aug END


" }}}
