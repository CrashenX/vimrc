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

"""""""""
" Setup "
"""""""""
" Clear any existing autocommands
autocmd!
set secure          " Protect your back door >_>;
set modeline        " allow modelines
set comments+=b:\"  " enable '"' as a comment type
set tags=tags;/     " check for tags from . to /

" Slowness fix for vim-jedi: disable jedi signature popup
"     https://github.com/davidhalter/jedi-vim/issues/217
let g:jedi#show_call_signatures = "0"

let g:go_fmt_command = "goimports"

"""""""""""
" Plugins "
"""""""""""
" To enable pathogen (for non-root user):
"     cd $HOME/src/vim/; git clone git@github.com:tpope/vim-pathogen.git
" To enable for root user (install for non-root user first):
"     cd $HOME/src/vim/; su -c 'mkdir -p $HOME/src; ln -s $(pwd) $HOME/src/vim'
source $HOME/src/vim/vim-pathogen/autoload/pathogen.vim
execute pathogen#infect('bundle/{}', '$HOME/src/vim/{}')
" Install the following plugins:
"     cd $HOME/src/vim/; git clone https://github.com/NLKNguyen/papercolor-theme.git
"     cd $HOME/src/vim/; git clone https://github.com/davidhalter/jedi-vim.git
"     cd $HOME/src/vim/; git clone https://github.com/editorconfig/editorconfig-vim.git
"     cd $HOME/src/vim/; git clone https://github.com/ervandew/supertab.git
"     cd $HOME/src/vim/; git clone https://github.com/fatih/vim-go.git
"     cd $HOME/src/vim/; git clone https://github.com/fs111/pydoc.vim.git
"     cd $HOME/src/vim/; git clone https://github.com/mileszs/ack.vim.git
"     cd $HOME/src/vim/; git clone https://github.com/neoclide/coc.nvim
"     cd $HOME/src/vim/; git clone https://github.com/nvie/vim-flake8.git
"     cd $HOME/src/vim/; git clone https://github.com/scrooloose/nerdtree.git
"     cd $HOME/src/vim/; git clone https://github.com/sjl/gundo.vim.git
"     cd $HOME/src/vim/; git clone https://github.com/tpope/vim-fugitive.git
"     cd $HOME/src/vim/; git clone https://github.com/tpope/vim-pathogen.git
"     cd $HOME/src/vim/; git cloen https://github.com/vim-python/python-syntax.git
autocmd BufWritePost *.py call Flake8()
let g:python_highlight_all = 1 " Enable python-syntax highlighting

"""""""""""
" Buffers "
"""""""""""
set hidden " Hide buffer; don't close (keep undo stack)

"""""""""
" Xclip "
"""""""""
noremap <F3> ! xclip -f<CR>
noremap <F4> :w ! xclip -f<CR><CR>

""""""""""""""""""""""
" Command Remappings "
""""""""""""""""""""""
" have Y behave analogously to D and C rather than to dd and cc
" (which is already done by yy):
noremap Y y$

" Remap window split and tab navigayion:
nnoremap <c-h> <c-w>h
nnoremap <c-l> <c-w>l
nnoremap <c-j> <c-w>j
nnoremap <c-k> <c-w>k
nnoremap <s-l> :tabnext<CR>
nnoremap <s-h> :tabprev<CR>

" Enable tab in visual mode
vnoremap <tab> >
vnoremap <s-tab> <

"""""""""""""""""
" Print Options "
"""""""""""""""""
set printexpr=PrintFile(v:fname_in)
function PrintFile(fname)
    call system("lp " . a:fname)
    call delete(a:fname)
    return v:shell_error
endfunc

"""""""""
" Input "
"""""""""
set visualbell t_vb= " turn off bell

if has('mouse')
  set mouse=a " enable mouse
endif

""""""""""""""
" Appearance "
""""""""""""""
set t_Co=256           " 256 color in terminal
set background=dark    " colors that look good with dark background
syntax on              " enable syntax highlighting
set nu                 " show line numbers
colorscheme PaperColor " custom color scheme

"""""""""""""""
" Status Line "
"""""""""""""""
set shortmess+=r " use "[RO]" for "[readonly]"

set showmode " show current mode (e.g. visual)

if has('cmdline_info')
    set ruler " show the ruler
    set rulerformat=%30(%=\:b%n%y%m%r%w\ %l,%c%V\ %P%) " a ruler on steroids
    set showcmd  " show paritally completed command
endif

if has('statusline')
        set laststatus=2

        " Broken down into easily includeable segments
        set statusline=%<%f                            " Filename
        set statusline+=%w%h%m%r                       " Options
        "set statusline+=\ [%{&ff}/%Y]                  " Filetype
        "set statusline+=\ cwd:%{getcwd()}              " Current Directory
        "set statusline+=\ [A=\%03.3b/H=\%02.2B]        " ASCII / Hex value of char
        set statusline+=%=%l,%c%V\ \                   " Row, Column
        set statusline+=%=%{fugitive#statusline()}\ \  " git info
        set statusline+=%=%p%%                         " % read
endif

"""""""""""""
" Searching "
"""""""""""""
set hlsearch   " highlighted search
set incsearch  " show the `best match so far' as search strings are typed 
set ignorecase " make searches case-insensitive ...
set smartcase  " ... unless they contain upper-case letters

"""""""""""""""""""""""""
" Autocomplete Settings "
"""""""""""""""""""""""""
filetype plugin on                   " filetype detection
set omnifunc=syntaxcomplete#Complete " intellisense
highlight Pmenu ctermbg=238 gui=bold

" Remap autocomplete menu control keys
" inoremap <expr> <Esc> pumvisible() ? "\<C-e>" : "\<Esc>"
" inoremap <expr> <CR>  pumvisible() ? "\<C-y>" : "\<CR>"
" inoremap <expr> j     pumvisible() ? "\<C-n>" : "j"
" inoremap <expr> k     pumvisible() ? "\<C-p>" : "k"
" inoremap <expr> h     pumvisible() ? "\<PageUp>\<C-n>\<C-p>"   : "h"
" inoremap <expr> l     pumvisible() ? "\<PageDown>\<C-n>\<C-p>" : "l"

let g:SuperTabCrMapping = 0 " prevent remap from breaking supertab
let g:SuperTabDefaultCompletionType = "context"
let g:SuperTabContextDefaultCompletionType = "<c-n>"

" have command-line completion <Tab> (for filenames, help topics, option names)
" first list the available options and complete the longest common part, then
" have further <Tab>s cycle through the possibilities:
set wildmode=list:longest,full

""""""""""""
" Spelling "
""""""""""""
set spellsuggest=10 " Max spelling suggestions
"set infercase       " Set case based on partially typed match

""""""""""""""
" Formatting "
""""""""""""""
set backspace=indent,eol,start " Enable backspace over everything
set showmatch                  " Show matching brace briefly
set tabstop=4                  " Number of spaces that a tab counts for
set shiftwidth=4               " Number of spaces to use for autoindent
set softtabstop=4              " Enables backspace over 4 spaces
set expandtab                  " Spaces are used for tabs
set autoindent                 " Match indent automatically for next line
set smartindent                " C, C++, & Java should default to cindent
set foldmethod=syntax          " Syntax folding
set textwidth=79               " Set maximum width of text (not code)
set nowrap                     " Don't wrap text
filetype indent on             " Load filetype specific indent file

" Now with ":set list" every tab will be displayed as ">---"
" (with more or less "-") and trailing white space as "-".
execute 'set listchars=tab:>-,trail:-'
execute 'set list'

autocmd BufNewFile,BufRead *.pde set filetype=java " Use java coloring

