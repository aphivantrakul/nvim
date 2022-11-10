" --------
" Settings
" --------
  set nocompatible " don't use vi settings
  syntax enable " enable syntax and plugins (for netrw)
  set path=.,,,**
  set hidden " allow switch buffers without saving
  set shortmess-=S " count number of search matches
  let g:netrw_fastbrowse = 0
  set t_Co=256 " use 256 colors on the terminal
  set ignorecase " case insensitive search
  set smartcase " case insensitive search
  set wildmenu " show tab options when searching
  set wildignore+=*/node_modules/*,*/tmp/*,*/public/* " ignore these folders when searching
  set wildmode=list:longest,full
  set clipboard=unnamedplus " copy from vim paste into system using * register
  set grepprg=rg\ --smart-case\ --vimgrep
  set tabstop=2 " 2 spaces for a tab
  set shiftwidth=2
  set softtabstop=2
  set expandtab
  set termguicolors
  set laststatus=2
  set statusline=%m%t
  set statusline+=%=
  set statusline+=%F
  set statusline+=%=
  set statusline+=%l/%L\ [\ %00p%%\ ]
  " set statusline=%<%f\ %h%m%r%=%-14.(%l,%c%V%)\ %P
  " set statusline=%t
  " set statusline+=%8*\ %=\ %l/%L\ (%00p%%)
  au FocusLost * silent! wa

  " turn syntax highlight off when using vimdiff
    if &diff
      syntax off
    endif
  set linebreak
  set expandtab
  set title
  set updatetime=100
  set undofile
  set list
  set listchars=tab:▸\ ,trail:·
  set scrolloff=4
  set sidescrolloff=10
  set splitright
  set nowrap
  " set titlestring=%(\ %M%)%(\ %M%)%(\ %M%)%(\ %M%)%(\ %M%)%(_____\ %)%t%(\ _____(%{expand(\"%:~:h\")})%)%(\ %a%)
  set startofline
  set foldmethod=indent
  set nofoldenable
  set autoindent
  set number
  " Use ripgrep for vim grep
    set grepprg=rg\ --color=never
  " vimdiff ignore whitespace
    " set diffopt+=iwhite
    " set diffexpr=""
  " tree-sitter folding
    set foldmethod=expr
    set foldexpr=nvim_treesitter#foldexpr()
  let g:netrw_sort_sequence = '[\/]$,*,\.bak$,\.o$,\.info$,\.swp$,\.obj$'
  " open NERDTree in full screen mode
    let g:NERDTreeWinSize = 40
  " hide ^G symbol in NERDTree side panel
    let g:NERDTreeNodeDelimiter = "\u00a0"
  " show hidden files in NERDTree by default
    let NERDTreeShowHidden=1

" --------
" Key Maps
" --------
  nnoremap <SPACE> <Nop>
  let mapleader=" "
  " map <leader>p :CtrlP<CR>
  " map <leader>b :CtrlPBuffer<CR>
  map <leader>b :BuffergatorToggle<CR>
  " noremap <leader>b :ls<cr>:b<space>
  map <leader>f :Files!<CR>
  map <leader>r :Rg!<CR>
  map <leader>/ :BLines<CR>
  noremap <leader>a :Arg 
  " noremap <leader>s :Srg 
  map <leader>h :History<CR>
  map <c-h> <c-w>wh
  map <c-j> <c-w>wj
  map <c-k> <c-w>wk
  map <c-l> <c-w>wl
  map <c-Left> <c-w>wh
  map <c-Down> <c-w>wj
  map <c-Up> <c-w>wk
  map <c-Right> <c-w>wl
  map <leader><Left> <c-w>wh
  map <leader><Down> <c-w>wj
  map <leader><Up> <c-w>wk
  map <leader><Right> <c-w>wl
  map <leader>W :set wrap!<CR>
  " map <leader>g :GitGutterToggle<CR>
  map <leader>c :set cursorcolumn!<CR>
  map <leader>n :set number!<CR>
  map <leader>l :set cursorline!<CR>
  " Reselect visual selection after indenting
    vnoremap < <gv
    vnoremap > >gv
  " Maintain the cursor position when yanking a visual selection
  " http://ddrscott.github.io/blog/2016/yank-without-jank/
    " vnoremap y myy`y
    " vnoremap Y myY`y
  " When text is wrapped, move by terminal rows, not lines, unless a count is provided
    noremap <silent> <expr> j (v:count == 0 ? 'gj' : 'j')
    noremap <silent> <expr> k (v:count == 0 ? 'gk' : 'k')
  " Quickly escape to normal mode
    " imap jj <esc>
  nnoremap <expr> <leader>t g:NERDTree.IsOpen() ? ':NERDTreeClose<CR>' : @% == '' ? ':NERDTree<CR>' : ':NERDTreeFind<CR>'
  " nmap <leader>t :NERDTreeToggle<CR>
  nmap <leader>T :NERDTreeFind<CR>
  " nmap <leader>e :Explore<CR>
  " nnoremap <expr> <leader>e &ft ==# "netrw" ? ':bd<CR>' : ':Explore<CR>'
  map <leader>] <c-]>
  map <leader>[ <c-t>
  map <leader>, :bp<CR>
  map <leader>. :bn<CR>
  map <leader>w :wa<CR>
  map <leader>q :q<CR>
  " map <leader>Q :qa!<CR>
  map <leader>1 :windo set wrap!<CR>
  nmap <leader>} <Plug>(GitGutterNextHunk)
  nmap <leader>{ <Plug>(GitGutterPrevHunk)
  nnoremap <leader>x :execute "set colorcolumn=" . (&colorcolumn == "" ? "100" : "")<CR>
  map <leader>c : close<CR>
  noremap <leader>R :%s/\<<C-r><C-w>\C\>//gc<Left><Left><Left>
  map <leader>B :Git blame<CR>
  " search for word without jumping to the next instance of the word
    nnoremap * :keepjumps normal! mi*`i<CR>
  " clear the last searched term by hitting return
    nnoremap <silent> <CR> :noh<CR><CR>
  " toggle diff
    let s:diff_on = 0
    function! ToggleDiff()
        if s:diff_on
            windo diffoff!
            let s:diff_on = 0
        else
            windo diffthis
            let s:diff_on = 1
        endif
    endfunction
    nnoremap <leader>d :call ToggleDiff()<CR>
  " make sure that deleting with d does not clobber system registers
    " nnoremap y "+y
    " nnoremap Y "+Y
    " nnoremap p "+p
    " nnoremap P "+P
    " nnoremap x "_x
    " vnoremap y "+y
    " vnoremap Y "+Y
    " vnoremap p "+p
    " vnoremap P "+P
    " vnoremap x "_x
  " When 2 windows are open vertically, side-by-side, set scrollbind to scroll
  " both screens up and down simultaneously
    let s:scrollbind_on = 0
    function! ToggleScrollBind()
        if s:scrollbind_on
            windo set noscrollbind
            let s:scrollbind_on = 0
        else
            windo set scrollbind
            let s:scrollbind_on = 1
        endif
    endfunction
  nnoremap <leader>s :call ToggleScrollBind()<CR>
  " clear word search highlighting
    nnoremap <CR> :noh<CR><CR>
  map <c-p> <Nop>

" -------
" Plugins
" -------
  " Automatically install vim-plug
    let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
    if empty(glob(data_dir . '/autoload/plug.vim'))
      silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
      autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
    endif
  " list of plugins to install
    call plug#begin('~/.vim/plugged')
      " Plug 'ctrlpvim/ctrlp.vim'
      Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
      Plug 'junegunn/fzf.vim'
      " Plug 'airblade/vim-rooter'
      Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
      Plug 'norcalli/nvim-colorizer.lua'
      Plug 'tpope/vim-commentary'
      Plug 'preservim/nerdtree'
      " Plug 'nathanaelkane/vim-indent-guides'
      Plug 'tpope/vim-fugitive'
      " Plug 'p00f/nvim-ts-rainbow'
      Plug 'nvim-treesitter/playground'
      " Plug 'ggandor/leap.nvim'
      " Plug 'neovim/nvim-lspconfig'
      " Plug 'williamboman/mason.nvim'
      " Plug 'williamboman/mason-lspconfig.nvim'
      Plug 'jeetsukumaran/vim-buffergator'
    call plug#end()
  " fzf
    let g:fzf_layout = { 'up': '100%' }
    let g:fzf_preview_window = ['up:40%:hidden', 'ctrl-e']
    let g:fzf_history_window = ['up:100%']
    let g:fzf_history_dir = '~/.local/share/fzf-history'
    " Customise the Files command to use rg which respects .gitignore files
      command! -bang -nargs=? -complete=dir Files call fzf#run(fzf#wrap('files', fzf#vim#with_preview({ 'dir': <q-args>, 'sink': 'e', 'source': 'rg --files --hidden' }), <bang>0))
    " Add an AllFiles variation that ignores .gitignore files
      command! -bang -nargs=? -complete=dir AllFiles call fzf#run(fzf#wrap('allfiles', fzf#vim#with_preview({ 'dir': <q-args>, 'sink': 'e', 'source': 'rg --files --hidden --no-ignore' }), <bang>0))
    " Ignore matches in filenames when using Rg
      command! -bang -nargs=* Rg call fzf#vim#grep("rg --column --line-number --no-heading --color=always --smart-case ".shellescape(<q-args>), 1, fzf#vim#with_preview({'options': '--delimiter : --nth 4..'}), <bang>0)

    " I borrowed this from Jesse Youngman
    " Change how Rg works, so we can pass args in!
    " dropped -- and shellescape to pass all quoted args along, who knows if this
    " will break things? have to use quotes around special regex chars
    " and add file completion for dir arg
      command! -bang -nargs=+ -complete=file Arg call fzf#vim#grep("rg --column --line-number --no-heading --color=always --smart-case ".<q-args>, 1, fzf#vim#with_preview(), <bang>0)

    " I borrowed this from Jesse Youngman
    " Add slower, consistently sorted version for consistent ordering the next time you run the same search
      command! -bang -nargs=+ -complete=file Srg call fzf#vim#grep("rg --column --line-number --no-heading --color=always --smart-case --sort=path ".<q-args>, 1, fzf#vim#with_preview(), <bang>0)

    " Hide the status line
      " autocmd! FileType fzf set laststatus=0 noshowmode noruler | autocmd BufLeave <buffer> set laststatus=2 showmode ruler
  " ctrlp
    " show current file in buffer list
      " let g:ctrlp_match_current_file = 1
    " increase buffer list size
      " let g:ctrlp_match_window = 'min:1,max:999'

  " vim-in-- dent-guides
      " let g:indent_guides_enable_on_vim_startup = 1
      " let g:indent_guides_auto_colors = 0
  " buffergator
    let g:buffergator_viewport_split_policy = "B"
    let g:buffergator_suppress_keymaps = 1
    let g:buffergator_sort_regime = "mru"
    let g:buffergator_hsplit_size = 10
lua <<EOF
    -- tree-sitter
        -- :TSInstall vim
        -- :TSInstall cpp
        -- :TSInstall c
        require'nvim-treesitter.configs'.setup {
            ensure_installed = { 
                "cpp", "c", "vim", "lua", "dockerfile",
            },
            highlight = {
                enable = true,
                additional_vim_regex_highlighting = false,
            },
            indent = {
                enable = true,
            },
            -- rainbow = {
            --     enable = true,
            --     extended_mode = true,
            -- },
            playground = {
                enable = true,
            },
        }

    -- colorizer
        require'colorizer'.setup()

    -- leap
        -- require('leap').add_default_mappings()

    -- mason
        -- require("mason").setup()

    -- mason-lspconfig
        -- must setup mason-lspconfig after setting up mason
        -- i.e. "require("mason-lspconfig").setup()" must come after calling "require("mason").setup()
        -- require("mason-lspconfig").setup({
            -- ensure_installed = { "clangd", "cmake", "dockerls", "html", "tsserver", "cssls" }
        -- })

    -- nvim-lspconfig
        -- Mappings.
        -- See `:help vim.diagnostic.*` for documentation on any of the below functions
        -- local opts = { noremap=true, silent=true }
        -- vim.keymap.set('n', '<space>e', vim.diagnostic.open_float, opts)
        -- vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
        -- vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
        -- vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist, opts)

        -- Use an on_attach function to only map the following keys
        -- after the language server attaches to the current buffer
        -- local on_attach = function(client, bufnr)
          -- Enable completion triggered by <c-x><c-o>
          -- vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

          -- Mappings.
          -- See `:help vim.lsp.*` for documentation on any of the below functions
          -- local bufopts = { noremap=true, silent=true, buffer=bufnr }
          -- vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
          -- vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
          -- vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
          -- vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
          -- vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
          -- vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, bufopts)
          -- vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
          -- vim.keymap.set('n', '<space>wl', function()
          --   print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
          -- end, bufopts)
          -- vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, bufopts)
          -- vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, bufopts)
          -- vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action, bufopts)
          -- vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
          -- vim.keymap.set('n', '<space>f', function() vim.lsp.buf.format { async = true } end, bufopts)
        -- end

        -- local lsp_flags = {
        --   -- This is the default in Nvim 0.7+
        --   debounce_text_changes = 150,
        -- }
        -- require'lspconfig'.clangd.setup{}
        -- require'lspconfig'.cmake.setup{}
        -- require'lspconfig'.dockerls.setup{}
        -- require'lspconfig'.html.setup{}
        -- require'lspconfig'.tsserver.setup{}
        -- require'lspconfig'.cssls.setup{}
EOF

" -------------------
" Syntax Highlighting
" -------------------
  hi clear
  if exists('syntax_on')
    syntax reset
  endif

  hi ALEErrorSign ctermbg=253 ctermfg=125 guibg=#dcdfe7 guifg=#cc517a
  hi ALEVirtualTextError ctermfg=125 guifg=#cc517a
  hi ALEVirtualTextWarning ctermfg=130 guifg=#c57339
  hi ALEWarningSign ctermbg=253 ctermfg=130 guibg=#dcdfe7 guifg=#c57339
  hi ColorColumn cterm=NONE ctermbg=253 ctermfg=NONE guibg=#dcdfe7 guifg=NONE
  hi Comment ctermfg=244 guifg=#8389a3
  hi Conceal ctermbg=254 ctermfg=244 guibg=#e8e9ec guifg=#8389a3
  hi Constant ctermfg=97 guifg=#7759b4
  " hi CtrlPMode1 ctermbg=247 ctermfg=252 guibg=#9fa6c0 guifg=#e8e9ec
  hi Cursor ctermbg=237 ctermfg=254 guibg=#393d52 guifg=#e8e9ec
  hi CursorColumn cterm=NONE ctermbg=253 ctermfg=NONE guibg=#dedede guifg=NONE
  hi CursorLine cterm=NONE ctermbg=253 ctermfg=NONE guibg=#cbcfda guifg=NONE
  hi CursorLineNr cterm=NONE ctermbg=251 ctermfg=237 guibg=NONE guifg=#cc517a
  hi Delimiter ctermfg=237 guifg=#7759b4
  hi DiffAdd ctermbg=79 ctermfg=23 guibg=#d4dbd1 guifg=#475946
  hi DiffChange ctermbg=116 ctermfg=24 guibg=#ced9e1 guifg=#375570
  hi DiffDelete cterm=NONE ctermbg=181 ctermfg=89 gui=NONE guibg=#e3d2da guifg=#70415e
  hi DiffText cterm=NONE ctermbg=73 ctermfg=24 gui=NONE guibg=#acc5d3 guifg=#393d52
  hi Directory ctermfg=31 guifg=#c57339
  hi EasyMotionShade ctermfg=250 guifg=#bbbecd
  hi EasyMotionTarget ctermfg=64 guifg=#668e3d
  hi EasyMotionTarget2First ctermfg=130 guifg=#c57339
  hi EasyMotionTarget2Second ctermfg=130 guifg=#c57339
  hi EndOfBuffer ctermfg=251 guifg=#cbcfda
  hi Error ctermbg=254 ctermfg=125 guibg=#e8e9ec guifg=#cc517a
  hi ErrorMsg ctermbg=254 ctermfg=125 guibg=#e8e9ec guifg=#cc517a
  hi FoldColumn ctermbg=253 ctermfg=248 guibg=#dcdfe7 guifg=#9fa7bd
  hi Folded ctermbg=253 ctermfg=243 guibg=#dcdfe7 guifg=#788098
  hi Function ctermfg=25 guifg=#7759b4
  hi GitGutterAdd ctermbg=253 ctermfg=64 guibg=#dcdfe7 guifg=#668e3d
  hi GitGutterChange ctermbg=253 ctermfg=31 guibg=#dcdfe7 guifg=#0584b3
  hi GitGutterChangeDelete ctermbg=253 ctermfg=31 guibg=#dcdfe7 guifg=#0584b3
  hi GitGutterDelete ctermbg=253 ctermfg=125 guibg=#dcdfe7 guifg=#cc517a
  hi Identifier cterm=NONE ctermfg=31 guifg=#7759b4
  hi Ignore ctermbg=NONE ctermfg=NONE guibg=NONE guifg=NONE
  hi IncSearch cterm=reverse ctermfg=NONE gui=reverse guifg=NONE term=reverse
  hi Include ctermfg=25 guifg=#2d539e
  hi LineNr ctermbg=253 ctermfg=248 guibg=NONE guifg=#c57339
  hi MatchParen ctermbg=250 ctermfg=0 guibg=#bec0c9 guifg=#393d52
  hi ModeMsg ctermfg=244 guifg=#8389a3
  hi MoreMsg ctermfg=64 guifg=#668e3d
  hi NonText ctermfg=251 guifg=#cbcfda
  hi Normal ctermbg=254 ctermfg=237 guibg=#e8e9ec guifg=#2d539e
  hi Operator ctermfg=25 guifg=#2d539e
  hi Pmenu ctermbg=245 ctermfg=237 guibg=#cad0de guifg=#393d52
  hi PmenuSbar ctermbg=251 ctermfg=NONE guibg=#cad0de guifg=NONE
  hi PmenuSel ctermbg=248 ctermfg=235 guibg=#a7b2cd guifg=#393d52
  hi PmenuThumb ctermbg=237 ctermfg=NONE guibg=#393d52 guifg=NONE
  hi PreProc ctermfg=64 guifg=#668e3d
  hi Question ctermfg=64 guifg=#668e3d
  hi QuickFixLine ctermbg=251 ctermfg=237 guibg=#c9cdd7 guifg=#393d52
  hi Search ctermbg=180 ctermfg=94 guibg=#eac6ad guifg=#85512c
  hi SignColumn ctermbg=253 ctermfg=248 guibg=#dcdfe7 guifg=#9fa7bd
  hi Sneak ctermbg=97 ctermfg=254 guibg=#7759b4 guifg=#e8e9ec
  hi SneakScope ctermbg=251 ctermfg=244 guibg=#c9cdd7 guifg=#8389a3
  hi Special guifg=#7759b4 ctermfg=173 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
  hi SpecialKey ctermfg=248 guifg=#a5b0d3
  hi SpellBad ctermbg=181 ctermfg=237 gui=undercurl guifg=NONE guisp=#cc517a
  hi SpellCap ctermbg=117 ctermfg=237 gui=undercurl guifg=NONE guisp=#2d539e
  hi SpellLocal ctermbg=116 ctermfg=237 gui=undercurl guifg=NONE guisp=#0584b3
  hi SpellRare ctermbg=110 ctermfg=237 gui=undercurl guifg=NONE guisp=#7759b4
  hi Statement ctermfg=25 gui=NONE guifg=#7759b4
  hi StatusLine cterm=reverse ctermbg=252 ctermfg=243 gui=reverse guibg=#393d52 guifg=#eac6ad term=reverse
  hi StatusLineNC cterm=reverse ctermbg=244 ctermfg=251 gui=reverse guibg=#393d52 guifg=#dedede
  hi StatusLineTerm cterm=reverse ctermbg=252 ctermfg=243 gui=reverse guibg=#393d52 guifg=#eac6ad term=reverse
  hi StatusLineTermNC cterm=reverse ctermbg=244 ctermfg=251 gui=reverse guibg=#393d52 guifg=#e8e9ec
  hi StorageClass ctermfg=25 guifg=#2d539e
  hi String ctermfg=31 guifg=#0584b3
  hi Structure ctermfg=25 guifg=#2d539e
  hi SyntasticErrorSign ctermbg=253 ctermfg=125 guibg=#dcdfe7 guifg=#cc517a
  hi SyntasticStyleErrorSign ctermbg=253 ctermfg=125 guibg=#dcdfe7 guifg=#cc517a
  hi SyntasticStyleWarningSign ctermbg=253 ctermfg=130 guibg=#dcdfe7 guifg=#c57339
  hi SyntasticWarningSign ctermbg=253 ctermfg=130 guibg=#dcdfe7 guifg=#c57339
  hi TabLine cterm=NONE ctermbg=251 ctermfg=244 gui=NONE guibg=#cad0de guifg=#8b98b6
  hi TabLineFill cterm=reverse ctermbg=244 ctermfg=251 gui=reverse guibg=#8b98b6 guifg=#cad0de
  hi TabLineSel cterm=NONE ctermbg=254 ctermfg=237 gui=NONE guibg=#e8e9ec guifg=#606374
  hi TermCursorNC ctermbg=244 ctermfg=254 guibg=#8389a3 guifg=#e8e9ec
  hi Title ctermfg=130 gui=NONE guifg=#668e3d
  hi Todo ctermbg=254 ctermfg=64 guibg=#d4dbd1 guifg=#668e3d
  hi Type ctermfg=25 gui=NONE guifg=#2d539e
  hi Underlined cterm=underline ctermfg=25 gui=underline guifg=#2d539e term=underline
  hi VertSplit cterm=NONE ctermbg=251 ctermfg=251 gui=NONE guibg=#eac6ad guifg=#eac6ad
  hi Visual ctermbg=251 ctermfg=NONE guibg=#c9cdd7 guifg=NONE
  hi VisualNOS ctermbg=251 ctermfg=NONE guibg=#c9cdd7 guifg=NONE
  hi WarningMsg ctermbg=254 ctermfg=125 guibg=#e8e9ec guifg=#cc517a
  hi Whitespace ctermfg=251 guifg=#cbcfda
  hi WildMenu ctermbg=235 ctermfg=252 guibg=#32364c guifg=#e8e9ec
  hi ZenSpace ctermbg=125 guibg=#cc517a
  hi diffAdded ctermfg=64 guifg=#668e3d
  hi diffRemoved ctermfg=125 guifg=#cc517a
  hi gitmessengerEndOfBuffer ctermbg=253 ctermfg=248 guibg=#dcdfe7 guifg=#9fa7bd
  hi gitmessengerPopupNormal ctermbg=253 ctermfg=237 guibg=#dcdfe7 guifg=#393d52
  hi icebergALAccentRed ctermfg=125 guifg=#cc517a
  hi icebergNormalFg ctermfg=237 guifg=#393d52
  hi vimMapRhs ctermfg=25 gui=NONE guifg=#2d539e

  let g:terminal_color_0 = '#dcdfe7'
  let g:terminal_color_1 = '#cc517a'
  let g:terminal_color_2 = '#668e3d'
  let g:terminal_color_3 = '#c57339'
  let g:terminal_color_4 = '#2d539e'
  let g:terminal_color_5 = '#7759b4'
  let g:terminal_color_6 = '#ffffff'
  let g:terminal_color_7 = '#393d52'
  let g:terminal_color_8 = '#8389a3'
  let g:terminal_color_9 = '#cc3768'
  let g:terminal_color_10 = '#598030'
  let g:terminal_color_11 = '#b6662d'
  let g:terminal_color_12 = '#22478e'
  let g:terminal_color_13 = '#6845ad'
  let g:terminal_color_14 = '#0584b3'
  let g:terminal_color_15 = '#262a3f'

  "TS Settings"
  hi @boolean guifg=#7759b4 ctermfg=25 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
  hi @character guifg=#b6662d ctermfg=130 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
  hi @comment ctermfg=244 guifg=#8389a3
  hi @conditional guifg=#7759b4 ctermfg=61 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
  hi @constant guifg=#cc3768 ctermfg=61 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
  hi @constant.macro guifg=#7759b4 ctermfg=61 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
  hi @field guifg=#cc3768 ctermfg=25 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
  hi @function guifg=#0584b3 ctermfg=25 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
  hi @include guifg=#7759b4 ctermfg=61 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
  hi @keyword guifg=#7759b4 ctermfg=167 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
  hi @keyword.operator guifg=#668e3d ctermfg=65 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
  hi @method guifg=#0584b3 ctermfg=25 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
  hi @namespace guifg=#8389a3 ctermfg=65 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
  hi @number guifg=#c57339 ctermfg=65 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
  hi @operator guifg=#7759b4 ctermfg=97 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
  hi @parameter guifg=#2d539e ctermfg=25 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
  hi @preproc guifg=#7759b4 ctermfg=61 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
  hi @property guifg=#cc3768 ctermfg=25 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
  hi @punctuation ctermfg=244 guifg=#7759b4
  hi @punctuation.bracket ctermfg=244 guifg=#7759b4
  hi @repeat guifg=#7759b4 ctermfg=61 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
  hi @string guifg=#c57339 ctermfg=130 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
  hi @string.escape guifg=#c57339 ctermfg=130 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
  hi @type guifg=#668e3d ctermfg=65 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
  hi @variable guifg=#2d539e ctermfg=243 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE

  hi htmlArg guifg=#668e3d ctermfg=130 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
  hi htmlBold guifg=#2d539e ctermfg=130 guibg=NONE ctermbg=NONE gui=bold cterm=bold
  hi htmlEndTag guifg=#6845ad ctermfg=67 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
  hi htmlH1 guifg=#2d539e ctermfg=236 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
  hi htmlH2 guifg=#2d539e ctermfg=236 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
  hi htmlH3 guifg=#2d539e ctermfg=236 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
  hi htmlH4 guifg=#2d539e ctermfg=236 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
  hi htmlH5 guifg=#2d539e ctermfg=236 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
  hi htmlH6 guifg=#2d539e ctermfg=236 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
  hi htmlItalic guifg=#6845ad ctermfg=61 guibg=NONE ctermbg=NONE gui=italic cterm=italic
  hi htmlLink guifg=#2d539e ctermfg=67 guibg=NONE ctermbg=NONE gui=underline cterm=underline
  hi htmlSpecialChar guifg=#b6662d ctermfg=130 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
  hi htmlSpecialTagName guifg=#6845ad ctermfg=173 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
  hi htmlTag guifg=#6845ad ctermfg=67 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
  hi htmlTagN guifg=#6845ad ctermfg=25 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
  hi htmlTagName guifg=#6845ad ctermfg=173 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
  hi htmlTitle guifg=#c57339 ctermfg=173 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE

  hi NERDTreeNodeDelimiters guifg=#6845ad ctermfg=25 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
  hi NERDTreeFile guifg=#6845ad ctermfg=25 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
  hi NERDTreeExecFile guifg=#6845ad ctermfg=25 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE

  hi netrwExe guifg=#2d539e ctermfg=25 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
