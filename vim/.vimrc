" ~/.vimrc
" Matthew Hatch
" Last edited 2020-04-22

filetype off

" **************************************
" * VUNDLE CONFIG
" **************************************

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

Plugin 'altercation/vim-colors-solarized'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'scrooloose/nerdtree'
Plugin 'tpope/vim-fugitive'
Plugin 'Chiel92/vim-autoformat'
Plugin 'w0rp/ale'
Plugin 'Yggdroot/indentLine'
Plugin 'bkad/CamelCaseMotion'

call vundle#end()            " required
filetype plugin indent on    " required

packadd termdebug

" **************************************
" VARIABLES
" **************************************
set number                     " line numbering on
set relativenumber             " Show relative line numbers
set encoding=utf8              " default to UTF-8 encoding
set noerrorbells               " bye bye bells :)
set modeline                   " show what I'm doing
set showmode                   " show the mode on the dedicated line (see above)
set path+=**                   " Recursive search for file operations
set wildmenu                   " Better command line completion
set showcmd                    " Show partial commands in last line of screen
set ignorecase                 " search without regards to case
set smartcase                  " except when using capital letters
set hlsearch                   " Highlight search results
set splitbelow                 " h-split to bottom
set splitright                 " v-split to right
set backspace=indent,eol,start " backspace over everything
set fileformats=unix,dos,mac   " open files from mac/dos
set ruler                      " which line am I on?
set showmatch                  " highlight matching parentheses
set incsearch                  " incremental searching
set laststatus=2               " Always display status line
set confirm                    " Confirm instead of fail
set so=15                      " Pad edge of window by 15 lines when scrolling
set wrap                       " Wrap lines over the terminal buffer width

" Disable swap files and backups
set nobackup
set nowb
set noswapfile

" General indentation/formatting options
" Spaces to indent, 4-wide indent
set autoindent                 " Try to match indentation, allow smartindent
set expandtab                  " Tab outputs spaces
set shiftwidth=4               " Spaces per indentation step for autoindent
set tabstop=4                  " Number of spaces \t occupies
set smarttab                   " Insert tabs according to shiftwidth or (soft)tabstop based on context
set smartindent                " OK default autoindentation option for C-like languages
set textwidth=0                " Don't limit line length in unrecognized filetypes

" Miscellaneous options

set colorcolumn=+1             " Mark column to indicate overlength lines in code files

set ssop-=options              " don't store options in the session - we have this vimrc for that

" Syntax highlighting theme
syntax enable

" Ada-specific ftplugin options
let g:ada_standard_types=1          " Enable different coloring for Ada types from package Standard
let g:ada_gnat_extensions=1         " Enable GNAT extension syntax support
let g:ada_with_gnat_project_files=1 " Enable syntax highlighting for GPR files
let g:ada_default_compiler="gnat"   " Set default Ada compiler to GNAT

" Set these to 0 if your terminal emulator has issues with font styles
let g:solarized_bold=1
let g:solarized_underline=1
let g:solarized_italic=1

set background=dark
colorscheme solarized
let g:indentLine_char_list = ['|', '¦', '┆', '┊']

" Fix the coloring on the built-in Vim terminal
hi Terminal ctermbg=black guibg=black

" Ignore compiled files when autocompleting
set wildignore=*.o,*.exe,*.obj,*.class,*.jar,*~,*.pyc
if has("win16") || has("win32")
    set wildignore+=.git\*,.hg\*,.svn\*
else
    set wildignore+=*/.git/*,*/.hg/*,*/.svn/*,*/.DS_Store
endif

" Built-in file browser
let g:netrw_banner=0                            " Disable banner
let g:netrw_browse_split=4                      " Open in prior window
let g:netrw_altv=1                              " Split to right
let g:netrw_liststyle=3                         " Display as tree

" airline
let g:airline_theme='badwolf'
let g:airline_solarized_bg='dark'
let g:airline_powerline_fonts = 1

if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif

" unicode symbols
let g:airline_left_sep = '»'
let g:airline_left_sep = '▶'
let g:airline_right_sep = '«'
let g:airline_right_sep = '◀'
let g:airline_symbols.linenr = '␊'
let g:airline_symbols.linenr = '␤'
let g:airline_symbols.linenr = '¶'
let g:airline_symbols.branch = '⎇'
let g:airline_symbols.paste = 'ρ'
let g:airline_symbols.paste = 'Þ'
let g:airline_symbols.paste = '∥'
let g:airline_symbols.whitespace = 'Ξ'

" airline symbols
let g:airline_left_sep = ''
let g:airline_left_alt_sep = ''
let g:airline_right_sep = ''
let g:airline_right_alt_sep = ''
let g:airline_symbols.branch = ''
let g:airline_symbols.readonly = ''
let g:airline_symbols.linenr = ''

" Linter config
let g:ale_linters = {
            \   'ada': ['gcc'],
            \   'c': ['clangd', 'clangtidy'],
            \   'cpp': ['clangd', 'clangtidy'],
            \   'haskell': ['stack-build']
            \}
" Enable airline integration with ALE (warning/error count)
let g:airline#extensions#ale#enabled = 1

" For airline whitespace checking:
"
" Allow mixed-indent files as long as they adhere to a 'tabs for indentation,
" spaces for alignment' style
let g:airline#extensions#whitespace#mixed_indent_algo = 2
" Set which whitespace checks to run
let g:airline#extensions#whitespace#checks = [ 'indent', 'trailing', 'long',
            \ 'mixed-indent-file', 'conflicts' ]

" Haskell linter configuration
" Stop passing --fast; this forces the whole project to recompile when running
" any stack commands manually unless you also specify --fast
let g:ale_haskell_stack_build_options = ""
let g:ale_haskell_stack_ghc_options = "-fno-code -v0 -Wall -WCompat -incomplete-uni-patterns
            \ -Wredundant-constraints"

" Miscellaneous
let g:tex_flavor = "latex" " Default to LaTeX if can't determine type of .tex file
let g:tex_conceal = ""     " Stop hiding LaTeX markup

" Grep for the given word, skip the prompt, open quickfix window
function Grep_internal(term)
    silent execute " grep -srnw --binary-files=without-match --exclude-dir=.git --exclude-dir=.stack-work
                \ --exclude-from=exclude.list . -e " . a:term . " "
    redraw!
    cwindow
endfunction

" **************************************
" KEYMAPS
" **************************************
let mapleader = ","
let g:camelcasemotion_key = '<Leader>'

noremap <F3> :Autoformat<CR>

" Move between splits
noremap <C-j> <C-W>j
noremap <C-k> <C-W>k
noremap <C-h> <C-W>h
noremap <C-l> <C-W>l

" Disable Arrow keys in Escape mode
noremap <up> <nop>
noremap <down> <nop>
noremap <left> <nop>
noremap <right> <nop>

" Move rest of line up a line
noremap L DO<c-r>"<ESC>

" Easy exit from insert mode
inoremap jj <ESC>

" Easy paging to save the J and K keys from dying...Shift-Space may not be
" distinguishable from Space on some terminal emulators
nnoremap <Space> 10j
nnoremap <S-Space> 10k

" Save with leader
nnoremap <Leader>W :w<CR>
" "make" current project
nnoremap <Leader>m :!build DEBUG<CR>
" Regenerate ctags file
nnoremap <Leader>t :!ctags --recurse=yes --totals=yes . <CR>
" Reload the vimrc after a change
nnoremap <Leader>r :so $MYVIMRC<CR>
" Toggle file explorer
nnoremap <Leader>f :NERDTreeToggle<CR>
" List the active buffers and prep to load one
nnoremap <Leader>B :ls<CR>:b<Space>
" Remove trailing whitespace in current file
nnoremap <Leader>$ :%s/\s\+$//e<CR>
" Open/close the location list
noremap <Leader>l :lopen<CR>
noremap <Leader>L :lclose<CR>
" Navigate between warnings/errors in ALE
noremap <Leader>j <Plug>(ale_next_wrap)<CR>
noremap <Leader>k <Plug>(ale_previous_wrap)<CR>

" Session commands
"
" Save the current session
nnoremap <Leader>ss :exec "mksession! " . v:this_session<CR>
" Prep to load a session
nnoremap <Leader>sl :so ~/.vim/sessions/
" Write all open buffers, then save the current session
nnoremap <Leader>sq :exec "mksession! " . v:this_session<CR>:xa<CR>

" Grep commands
"
" Grep for word under cursor in project
noremap <Leader>gp :call Grep_internal(expand("<cword>"))<CR>
" Grep for word under cursor in file; open results in loclist
noremap <Leader>gf :lvimgrep <cword> %<CR>:lopen<CR>

command! -nargs=1 Grep :call Grep_internal(<f-args>)

" Avoid duplication of autocmds
if !exists("autocmds_loaded")
    let autocmds_loaded=1

    " Move cursorline with active window
    augroup CursorLine
        au!
        au VimEnter,WinEnter,BufWinEnter * setlocal cursorline
        au WinLeave * setlocal nocursorline
    augroup END
endif
