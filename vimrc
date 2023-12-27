"""""""""""
" Plugins "
"""""""""""
call plug#begin()
" Theme
Plug 'NLKNguyen/papercolor-theme'
" Git Blame, etc.
Plug 'tpope/vim-fugitive'
" Git Diff
Plug 'nvim-lua/plenary.nvim'
Plug 'sindrets/diffview.nvim'
Plug 'kyazdani42/nvim-web-devicons'
" Fuzzy Search
Plug 'Yggdroot/LeaderF', { 'do': ':LeaderfInstallCExtension' }
" Language Help
Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-cmdline'
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-vsnip'
Plug 'hrsh7th/vim-vsnip'
call plug#end()

"""""""""
" Setup "
"""""""""
" Clear any existing autocommands
autocmd!
set secure          " Protect your back door >_>;
set modeline        " allow modelines
set comments+=b:\"  " enable '"' as a comment type
set tags=tags;/     " check for tags from . to /

""""""
" Go "
""""""
let g:go_fmt_command = "goimports"

""""""""""
" Python "
""""""""""
autocmd BufWritePost *.py call Flake8()
autocmd BufRead,BufNewFile *.py let python_highlight_all=1
" Slowness fix for vim-jedi: disable jedi signature popup
"     https://github.com/davidhalter/jedi-vim/issues/217
let g:jedi#show_call_signatures = "0"

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
" filetype plugin on                   " filetype detection
" set omnifunc=syntaxcomplete#Complete " intellisense
" highlight Pmenu ctermbg=238 gui=bold
"
" " Remap autocomplete menu control keys
" " inoremap <expr> <Esc> pumvisible() ? "\<C-e>" : "\<Esc>"
" " inoremap <expr> <CR>  pumvisible() ? "\<C-y>" : "\<CR>"
" " inoremap <expr> j     pumvisible() ? "\<C-n>" : "j"
" " inoremap <expr> k     pumvisible() ? "\<C-p>" : "k"
" " inoremap <expr> h     pumvisible() ? "\<PageUp>\<C-n>\<C-p>"   : "h"
" " inoremap <expr> l     pumvisible() ? "\<PageDown>\<C-n>\<C-p>" : "l"
"
" let g:SuperTabCrMapping = 0 " prevent remap from breaking supertab
" let g:SuperTabDefaultCompletionType = "context"
" let g:SuperTabContextDefaultCompletionType = "<c-n>"
"
" " have command-line completion <Tab> (for filenames, help topics, option names)
" " first list the available options and complete the longest common part, then
" " have further <Tab>s cycle through the possibilities:
" set wildmode=list:longest,full

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

""""""""""""
" nvim-cmp "
""""""""""""
set completeopt=menu,menuone,noselect

lua <<EOF
  -- Setup nvim-cmp.
  local cmp = require'cmp'

  cmp.setup({
    snippet = {
      expand = function(args)
        vim.fn["vsnip#anonymous"](args.body)
      end,
    },
    window = {
      -- completion = cmp.config.window.bordered(),
      -- documentation = cmp.config.window.bordered(),
    },
    mapping = cmp.mapping.preset.insert({
            ['<Tab>'] = function(fallback)
              if cmp.visible() then
                cmp.select_next_item()
              else
                fallback()
              end
            end,
            ['<S-Tab>'] = function(fallback)
              if cmp.visible() then
                cmp.select_prev_item()
              else
                fallback()
              end
            end,
            ['<CR>'] = cmp.mapping.confirm({ select = true }),
            ['<C-e>'] = cmp.mapping.abort(),
            ['<Esc>'] = cmp.mapping.close(),
            ['<C-b>'] = cmp.mapping.scroll_docs(-4),
            ['<C-f>'] = cmp.mapping.scroll_docs(4),
          }),
    sources = cmp.config.sources({
      { name = 'nvim_lsp' },
      { name = 'vsnip' },
      { name = 'path' }, -- for path completion
      { name = 'omni' },
      { name = 'emoji', insert = true, } -- emoji completion
    }, {
      { name = 'buffer' },
    })
  })

  -- Set configuration for specific filetype.
  cmp.setup.filetype('gitcommit', {
    sources = cmp.config.sources({
      { name = 'cmp_git' }, -- You can specify the `cmp_git` source if you were installed it.
    }, {
      { name = 'buffer' },
    })
  })

  -- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
  cmp.setup.cmdline('/', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = {
      { name = 'buffer' }
    }
  })

  -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
  cmp.setup.cmdline(':', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({
      { name = 'path' }
    }, {
      { name = 'cmdline' }
    })
  })

  -- Setup lspconfig.
  local capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities())
  -- Replace <YOUR_LSP_SERVER> with each lsp server you've enabled.
  require('lspconfig')['pyright'].setup {
    capabilities = capabilities
  }
  require('lspconfig')['gopls'].setup {
    capabilities = capabilities
  }

  vim.cmd[[
    highlight! link CmpItemMenu Comment
    " gray
    highlight! CmpItemAbbrDeprecated guibg=NONE gui=strikethrough guifg=#808080
    " blue
    highlight! CmpItemAbbrMatch guibg=NONE guifg=#569CD6
    highlight! CmpItemAbbrMatchFuzzy guibg=NONE guifg=#569CD6
    " light blue
    highlight! CmpItemKindVariable guibg=NONE guifg=#9CDCFE
    highlight! CmpItemKindInterface guibg=NONE guifg=#9CDCFE
    highlight! CmpItemKindText guibg=NONE guifg=#9CDCFE
    " pink
    highlight! CmpItemKindFunction guibg=NONE guifg=#C586C0
    highlight! CmpItemKindMethod guibg=NONE guifg=#C586C0
    " front
    highlight! CmpItemKindKeyword guibg=NONE guifg=#D4D4D4
    highlight! CmpItemKindProperty guibg=NONE guifg=#D4D4D4
    highlight! CmpItemKindUnit guibg=NONE guifg=#D4D4D4
  ]]
EOF

"""""""""""
" Leaderf "
"""""""""""

" Change leader to ,
let mapleader = ","

" Do not use cache file
let g:Lf_UseCache = 0
" Refresh each time we call leaderf
let g:Lf_UseMemoryCache = 0

" Ignore certain files and directories when searching files
let g:Lf_WildIgnore = {
  \ 'dir': ['.git', '__pycache__', '.DS_Store'],
  \ 'file': ['*.exe', '*.dll', '*.so', '*.o', '*.pyc', '*.jpg', '*.png',
  \ '*.gif', '*.svg', '*.ico', '*.db', '*.tgz', '*.tar.gz', '*.gz',
  \ '*.zip', '*.bin', '*.pptx', '*.xlsx', '*.docx', '*.pdf', '*.tmp',
  \ '*.wmv', '*.mkv', '*.mp4', '*.rmvb', '*.ttf', '*.ttc', '*.otf',
  \ '*.mp3', '*.aac']
  \}

" Only fuzzy-search files names
let g:Lf_DefaultMode = 'FullPath'

" Popup window settings
let w = float2nr(&columns * 0.8)
if w > 140
  let g:Lf_PopupWidth = 140
else
  let g:Lf_PopupWidth = w
endif

let g:Lf_PopupPosition = [0, float2nr((&columns - g:Lf_PopupWidth)/2)]

" Do not use version control tool to list files under a directory since
" submodules are not searched by default.
let g:Lf_UseVersionControlTool = 0

" Use rg as the default search tool
let g:Lf_DefaultExternalTool = "rg"

" show dot files
let g:Lf_ShowHidden = 1

" Disable default mapping
let g:Lf_ShortcutF = ''
let g:Lf_ShortcutB = ''

" set up working directory for git repository
let g:Lf_WorkingDirectoryMode = 'a'

" Search files in popup window
nnoremap <silent> <leader>ff :<C-U>Leaderf file --popup<CR>

" Grep project files in popup window
nnoremap <silent> <leader>fg :<C-U>Leaderf rg --no-messages --popup<CR>

" Search vim help files
nnoremap <silent> <leader>fh :<C-U>Leaderf help --popup<CR>

" Search tags in current buffer
nnoremap <silent> <leader>ft :<C-U>Leaderf bufTag --popup<CR>

" Switch buffers
nnoremap <silent> <leader>fb :<C-U>Leaderf buffer --popup<CR>

" Search recent files
nnoremap <silent> <leader>fr :<C-U>Leaderf mru --popup --absolute-path<CR>
