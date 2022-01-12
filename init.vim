" --------
" Settings
" --------
    set nocompatible " don't use vi settings
    syntax enable " enable syntax and plugins (for netrw)
    filetype plugin on
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
    set clipboard=unnamed " copy from vim paste into system using * register
    set grepprg=rg\ --smart-case\ --vimgrep
    set tabstop=2 " 2 spaces for a tab
    set shiftwidth=2
    set softtabstop=2
    set expandtab
    set termguicolors
    set laststatus=1
    " turn syntax highlight off when using vimdiff
        if &diff
          syntax off
        endif
    set linebreak
    setlocal foldmethod=indent
    set expandtab
    set nofoldenable
    set title
    set updatetime=100
    set undofile
    set list
    set listchars=tab:▸\ ,trail:·
    set scrolloff=8
    set sidescrolloff=10
    set splitright
    set clipboard=unnamedplus
" --------
" Key Maps
" --------
    nnoremap <SPACE> <Nop>
    let mapleader=" "
    map <leader>p :CtrlP<CR>
    map <leader>b :CtrlPBuffer<CR>
    nnoremap <SPACE> <Nop>
    let mapleader=" "
    map <leader>f :Files!<CR>
    map <leader>r :Rg!<CR>
    map <c-h> <c-w>wh
    map <c-j> <c-w>wj
    map <c-k> <c-w>wk
    map <c-l> <c-w>wl
    map <leader>w :set wrap!<CR>
    map <leader>g :GitGutterToggle<CR>
    map <leader>c :set cursorcolumn!<CR>
    map <leader>n :set number!<CR>
    map <leader>l :set cursorline!<CR>
    " Reselect visual selection after indenting
        vnoremap < <gv
        vnoremap > >gv
    " Maintain the cursor position when yanking a visual selection
    " http://ddrscott.github.io/blog/2016/yank-without-jank/
        vnoremap y myy`y
        vnoremap Y myY`y
    " When text is wrapped, move by terminal rows, not lines, unless a count is provided
        noremap <silent> <expr> j (v:count == 0 ? 'gj' : 'j')
        noremap <silent> <expr> k (v:count == 0 ? 'gk' : 'k')
    " Quicky escape to normal mode
        imap jj <esc>
    nnoremap <expr> <leader>t g:NERDTree.IsOpen() ? ':NERDTreeClose<CR>' : @% == '' ? ':NERDTree<CR>' : ':NERDTreeFind<CR>'
    nmap <leader>T :NERDTreeFind<CR>
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
          Plug 'ctrlpvim/ctrlp.vim'
          Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
          Plug 'junegunn/fzf.vim'
          Plug 'airblade/vim-rooter'
          Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
          Plug 'norcalli/nvim-colorizer.lua'
          Plug 'tpope/vim-commentary'
          Plug 'airblade/vim-gitgutter'
          Plug 'preservim/nerdtree'
        call plug#end()
    " git gutter
        let g:gitgutter_diff_base = 'HEAD'
        let g:gitgutter_enabled = 0
        let g:fzf_preview_window = ['up:50%:hidden', 'ctrl-/']
    " fzf
        " Customise the Files command to use rg which respects .gitignore files
            command! -bang -nargs=? -complete=dir Files call fzf#run(fzf#wrap('files', fzf#vim#with_preview({ 'dir': <q-args>, 'sink': 'e', 'source': 'rg --files --hidden' }), <bang>0))
        " Add an AllFiles variation that ignores .gitignore files
            command! -bang -nargs=? -complete=dir AllFiles call fzf#run(fzf#wrap('allfiles', fzf#vim#with_preview({ 'dir': <q-args>, 'sink': 'e', 'source': 'rg --files --hidden --no-ignore' }), <bang>0))
    " ctrlp
        " show current file in buffer list
            let g:ctrlp_match_current_file = 1
        " increase buffer list size
            let g:ctrlp_match_window = 'min:1,max:999'
" tree-sitter
lua <<EOF
  require'nvim-treesitter.configs'.setup {
    ensure_installed = "maintained",
    sync_install = false,
    ignore_install = {},
    highlight = {
      enable = true,
      disable = {},
      additional_vim_regex_highlighting = false,
    },
  }
  require'colorizer'.setup()
EOF

" ----------------
" Syntax Highlight
" ----------------
    hi clear
    if exists('syntax_on')
      syntax reset
    endif

    hi Normal ctermbg=254 ctermfg=237 guibg=#e8e9ec guifg=#33374c
    hi ColorColumn cterm=NONE ctermbg=253 ctermfg=NONE guibg=#dcdfe7 guifg=NONE
    hi CursorColumn cterm=NONE ctermbg=253 ctermfg=NONE guibg=#dedede guifg=NONE
    hi CursorLine cterm=NONE ctermbg=253 ctermfg=NONE guibg=#cbcfda guifg=NONE
    hi Comment ctermfg=244 guifg=#8389a3
    hi Conceal ctermbg=254 ctermfg=244 guibg=#e8e9ec guifg=#8389a3
    hi Constant ctermfg=97 guifg=#7759b4
    hi Cursor ctermbg=237 ctermfg=254 guibg=#33374c guifg=#e8e9ec
    hi CursorLineNr cterm=NONE ctermbg=251 ctermfg=237 guibg=NONE guifg=#c57339 " changed
    hi Delimiter ctermfg=237 guifg=#33374c
    hi DiffAdd ctermbg=79 ctermfg=23 guibg=#d4dbd1 guifg=#475946
    hi DiffChange ctermbg=116 ctermfg=24 guibg=#ced9e1 guifg=#375570
    hi DiffDelete cterm=NONE ctermbg=181 ctermfg=89 gui=NONE guibg=#e3d2da guifg=#70415e
    hi DiffText cterm=NONE ctermbg=73 ctermfg=24 gui=NONE guibg=#acc5d3 guifg=#33374c
    hi Directory ctermfg=31 guifg=#3f83a6
    hi Error ctermbg=254 ctermfg=125 guibg=#e8e9ec guifg=#cc517a
    hi ErrorMsg ctermbg=254 ctermfg=125 guibg=#e8e9ec guifg=#cc517a
    hi WarningMsg ctermbg=254 ctermfg=125 guibg=#e8e9ec guifg=#cc517a
    hi EndOfBuffer ctermfg=251 guifg=#cbcfda
    hi NonText ctermfg=251 guifg=#cbcfda
    hi Whitespace ctermfg=251 guifg=#cbcfda
    hi Folded ctermbg=253 ctermfg=243 guibg=#dcdfe7 guifg=#788098
    hi FoldColumn ctermbg=253 ctermfg=248 guibg=#dcdfe7 guifg=#9fa7bd
    hi Function ctermfg=25 guifg=#2d539e
    hi Identifier cterm=NONE ctermfg=31 guifg=#3f83a6
    hi Ignore ctermbg=NONE ctermfg=NONE guibg=NONE guifg=NONE
    hi Include ctermfg=25 guifg=#2d539e
    hi IncSearch cterm=reverse ctermfg=NONE gui=reverse guifg=NONE term=reverse
    hi LineNr ctermbg=253 ctermfg=248 guibg=NONE guifg=#c57339 " changed
    hi MatchParen ctermbg=250 ctermfg=0 guibg=#bec0c9 guifg=#33374c
    hi ModeMsg ctermfg=244 guifg=#8389a3
    hi MoreMsg ctermfg=64 guifg=#668e3d
    hi Operator ctermfg=25 guifg=#2d539e
    hi Pmenu ctermbg=245 ctermfg=237 guibg=#cad0de guifg=#33374c
    hi PmenuSbar ctermbg=251 ctermfg=NONE guibg=#cad0de guifg=NONE
    hi PmenuSel ctermbg=248 ctermfg=235 guibg=#a7b2cd guifg=#33374c
    hi PmenuThumb ctermbg=237 ctermfg=NONE guibg=#33374c guifg=NONE
    hi PreProc ctermfg=64 guifg=#668e3d
    hi Question ctermfg=64 guifg=#668e3d
    hi QuickFixLine ctermbg=251 ctermfg=237 guibg=#c9cdd7 guifg=#33374c
    hi Search ctermbg=180 ctermfg=94 guibg=#eac6ad guifg=#85512c
    hi SignColumn ctermbg=253 ctermfg=248 guibg=#dcdfe7 guifg=#9fa7bd
    hi Special ctermfg=64 guifg=#668e3d
    hi SpecialKey ctermfg=248 guifg=#a5b0d3
    hi SpellBad ctermbg=181 ctermfg=237 gui=undercurl guifg=NONE guisp=#cc517a
    hi SpellCap ctermbg=117 ctermfg=237 gui=undercurl guifg=NONE guisp=#2d539e
    hi SpellLocal ctermbg=116 ctermfg=237 gui=undercurl guifg=NONE guisp=#3f83a6
    hi SpellRare ctermbg=110 ctermfg=237 gui=undercurl guifg=NONE guisp=#7759b4
    hi Statement ctermfg=25 gui=NONE guifg=#2d539e
    hi StatusLine cterm=reverse ctermbg=252 ctermfg=243 gui=reverse guibg=#c57339 guifg=#eac6ad term=reverse
    hi StatusLineTerm cterm=reverse ctermbg=252 ctermfg=243 gui=reverse guibg=#c57339 guifg=#eac6ad term=reverse
    hi StatusLineNC cterm=reverse ctermbg=244 ctermfg=251 gui=reverse guibg=#33374c guifg=#e8e9ec
    hi StatusLineTermNC cterm=reverse ctermbg=244 ctermfg=251 gui=reverse guibg=#33374c guifg=#e8e9ec
    hi StorageClass ctermfg=25 guifg=#2d539e
    hi String ctermfg=31 guifg=#3f83a6
    hi Structure ctermfg=25 guifg=#2d539e
    hi TabLine cterm=NONE ctermbg=251 ctermfg=244 gui=NONE guibg=#cad0de guifg=#8b98b6
    hi TabLineFill cterm=reverse ctermbg=244 ctermfg=251 gui=reverse guibg=#8b98b6 guifg=#cad0de
    hi TabLineSel cterm=NONE ctermbg=254 ctermfg=237 gui=NONE guibg=#e8e9ec guifg=#606374
    hi TermCursorNC ctermbg=244 ctermfg=254 guibg=#8389a3 guifg=#e8e9ec
    hi Title ctermfg=130 gui=NONE guifg=#c57339
    hi Todo ctermbg=254 ctermfg=64 guibg=#d4dbd1 guifg=#668e3d
    hi Type ctermfg=25 gui=NONE guifg=#2d539e
    hi Underlined cterm=underline ctermfg=25 gui=underline guifg=#2d539e term=underline
    hi VertSplit cterm=NONE ctermbg=251 ctermfg=251 gui=NONE guibg=#dedede guifg=#dedede
    hi Visual ctermbg=251 ctermfg=NONE guibg=#c9cdd7 guifg=NONE
    hi VisualNOS ctermbg=251 ctermfg=NONE guibg=#c9cdd7 guifg=NONE
    hi WildMenu ctermbg=235 ctermfg=252 guibg=#32364c guifg=#e8e9ec
    hi icebergNormalFg ctermfg=237 guifg=#33374c
    hi diffAdded ctermfg=64 guifg=#668e3d
    hi diffRemoved ctermfg=125 guifg=#cc517a
    hi ALEErrorSign ctermbg=253 ctermfg=125 guibg=#dcdfe7 guifg=#cc517a
    hi ALEWarningSign ctermbg=253 ctermfg=130 guibg=#dcdfe7 guifg=#c57339
    hi ALEVirtualTextError ctermfg=125 guifg=#cc517a
    hi ALEVirtualTextWarning ctermfg=130 guifg=#c57339
    hi CtrlPMode1 ctermbg=247 ctermfg=252 guibg=#9fa6c0 guifg=#e8e9ec
    hi EasyMotionShade ctermfg=250 guifg=#bbbecd
    hi EasyMotionTarget ctermfg=64 guifg=#668e3d
    hi EasyMotionTarget2First ctermfg=130 guifg=#c57339
    hi EasyMotionTarget2Second ctermfg=130 guifg=#c57339
    hi GitGutterAdd ctermbg=253 ctermfg=64 guibg=#dcdfe7 guifg=#668e3d
    hi GitGutterChange ctermbg=253 ctermfg=31 guibg=#dcdfe7 guifg=#3f83a6
    hi GitGutterChangeDelete ctermbg=253 ctermfg=31 guibg=#dcdfe7 guifg=#3f83a6
    hi GitGutterDelete ctermbg=253 ctermfg=125 guibg=#dcdfe7 guifg=#cc517a
    hi gitmessengerEndOfBuffer ctermbg=253 ctermfg=248 guibg=#dcdfe7 guifg=#9fa7bd
    hi gitmessengerPopupNormal ctermbg=253 ctermfg=237 guibg=#dcdfe7 guifg=#33374c
    hi Sneak ctermbg=97 ctermfg=254 guibg=#7759b4 guifg=#e8e9ec
    hi SneakScope ctermbg=251 ctermfg=244 guibg=#c9cdd7 guifg=#8389a3
    hi SyntasticErrorSign ctermbg=253 ctermfg=125 guibg=#dcdfe7 guifg=#cc517a
    hi SyntasticStyleErrorSign ctermbg=253 ctermfg=125 guibg=#dcdfe7 guifg=#cc517a
    hi SyntasticStyleWarningSign ctermbg=253 ctermfg=130 guibg=#dcdfe7 guifg=#c57339
    hi SyntasticWarningSign ctermbg=253 ctermfg=130 guibg=#dcdfe7 guifg=#c57339
    hi ZenSpace ctermbg=125 guibg=#cc517a
    hi DiagnosticUnderlineInfo cterm=underline ctermfg=31 gui=underline guisp=#3f83a6 term=underline
    hi DiagnosticInfo ctermfg=31 guifg=#3f83a6
    hi DiagnosticSignInfo ctermbg=253 ctermfg=31 guibg=#dcdfe7 guifg=#3f83a6
    hi DiagnosticUnderlineHint cterm=underline ctermfg=244 gui=underline guisp=#8389a3 term=underline
    hi DiagnosticHint ctermfg=244 guifg=#8389a3
    hi DiagnosticSignHint ctermbg=253 ctermfg=244 guibg=#dcdfe7 guifg=#8389a3
    hi DiagnosticUnderlineWarn cterm=underline ctermfg=130 gui=underline guisp=#c57339 term=underline
    hi DiagnosticWarn ctermfg=130 guifg=#c57339
    hi DiagnosticSignWarn ctermbg=253 ctermfg=130 guibg=#dcdfe7 guifg=#c57339
    hi DiagnosticUnderlineError cterm=underline ctermfg=125 gui=underline guisp=#cc517a term=underline
    hi DiagnosticError ctermfg=125 guifg=#cc517a
    hi DiagnosticSignError ctermbg=253 ctermfg=125 guibg=#dcdfe7 guifg=#cc517a
    hi DiagnosticFloatingHint ctermbg=251 ctermfg=237 guibg=#cad0de guifg=#33374c
    hi icebergALAccentRed ctermfg=125 guifg=#cc517a
    let g:terminal_color_0 = '#dcdfe7'
    let g:terminal_color_1 = '#cc517a'
    let g:terminal_color_2 = '#668e3d'
    let g:terminal_color_3 = '#c57339'
    let g:terminal_color_4 = '#2d539e'
    let g:terminal_color_5 = '#7759b4'
    let g:terminal_color_6 = '#3f83a6'
    let g:terminal_color_7 = '#33374c'
    let g:terminal_color_8 = '#8389a3'
    let g:terminal_color_9 = '#cc3768'
    let g:terminal_color_10 = '#598030'
    let g:terminal_color_11 = '#b6662d'
    let g:terminal_color_12 = '#22478e'
    let g:terminal_color_13 = '#6845ad'
    let g:terminal_color_14 = '#327698'
    let g:terminal_color_15 = '#262a3f'

    "TS Settings"
    hi TSComment ctermfg=244 guifg=#8389a3
    hi TSError guifg=#cc3768 ctermfg=167 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
    hi TSPunctDelimiter guifg=#6845ad ctermfg=97 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
    hi TSPunctBracket guifg=#6845ad ctermfg=97 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
    hi TSPunctSpecial guifg=#6845ad ctermfg=97 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
    hi TSConstant guifg=#c57339 ctermfg=173 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
    hi TSConstBuiltin guifg=#2d539e ctermfg=25 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
    hi TSConstMacro guifg=#598030 ctermfg=65 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
    hi TSStringRegex guifg=#b6662d ctermfg=130 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
    hi TSString guifg=#c57339 ctermfg=130 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
    hi TSStringEscape guifg=#b6662d ctermfg=130 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
    hi TSCharacter guifg=#b6662d ctermfg=130 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
    hi TSNumber guifg=#668e3d ctermfg=65 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
    hi TSBoolean guifg=#2d539e ctermfg=25 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
    hi TSFloat guifg=#668e3d ctermfg=65 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
    hi TSAnnotation guifg=#c57339 ctermfg=173 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
    hi TSAttribute guifg=#598030 ctermfg=65 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
    hi TSNamespace guifg=#598030 ctermfg=65 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
    hi TSFuncBuiltin guifg=#c57339 ctermfg=173 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
    hi TSFunction ctermfg=237 guifg=#3f83a6
    hi TSFuncMacro guifg=#c57339 ctermfg=173 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
    hi TSParameter guifg=#2d539e ctermfg=25 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
    hi TSParameterReference guifg=#2d539e ctermfg=25 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
    hi TSMethod ctermfg=237 guifg=#3f83a6
    hi TSField guifg=#2d539e ctermfg=25 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
    hi TSProperty guifg=#2d539e ctermfg=25 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
    hi TSConstructor guifg=#598030 ctermfg=65 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
    hi TSConditional guifg=#7759b4 ctermfg=61 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
    hi TSRepeat guifg=#7759b4 ctermfg=61 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
    hi TSLabel guifg=#6f7378 ctermfg=243 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
    hi TSKeyword guifg=#7759b4 ctermfg=97 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
    hi TSKeywordFunction guifg=#7759b4 ctermfg=61 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
    hi TSKeywordOperator guifg=#2d539e ctermfg=25 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
    hi TSOperator guifg=#7759b4 ctermfg=97 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
    hi TSException guifg=#7759b4 ctermfg=61 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
    hi TSType guifg=#668e3d ctermfg=65 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
    hi TSTypeBuiltin guifg=#2d539e ctermfg=25 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
    hi TSStructure guifg=#ff00ff ctermfg=201 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
    hi TSInclude guifg=#6845ad ctermfg=61 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
    hi TSVariable guifg=#33374c ctermfg=243 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
    hi TSVariableBuiltin guifg=#2d539e ctermfg=25 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
    hi TSText guifg=#ffff00 ctermfg=226 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
    hi TSStrong guifg=#ffff00 ctermfg=226 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
    hi TSEmphasis guifg=#ffff00 ctermfg=226 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
    hi TSUnderline guifg=#ffff00 ctermfg=226 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
    hi TSTitle guifg=#ffff00 ctermfg=226 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
    hi TSLiteral guifg=#b6662d ctermfg=130 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
    hi TSURI cterm=underline ctermfg=31 gui=underline guifg=#3f83a6 term=underline
    hi TSTag guifg=#2d539e ctermfg=25 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
    hi TSTagDelimiter guifg=#6845ad ctermfg=237 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
    hi TSQueryLinterError guifg=#ff8800 ctermfg=208 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
    hi TSSymbol guifg=#cc517a ctermfg=168 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
    hi TSFunctionBuiltin ctermfg=237 guifg=#505695
    hi TSFunctionMacro ctermfg=237 guifg=#505695

    hi htmlArg guifg=#b6662d ctermfg=130 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
    hi htmlBold guifg=#b6662d ctermfg=130 guibg=NONE ctermbg=NONE gui=bold cterm=bold
    hi htmlEndTag guifg=#3f83a6 ctermfg=67 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
    hi htmlH1 guifg=#262a3f ctermfg=236 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
    hi htmlH2 guifg=#262a3f ctermfg=236 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
    hi htmlH3 guifg=#262a3f ctermfg=236 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
    hi htmlH4 guifg=#262a3f ctermfg=236 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
    hi htmlH5 guifg=#262a3f ctermfg=236 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
    hi htmlH6 guifg=#262a3f ctermfg=236 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
    hi htmlItalic guifg=#6845ad ctermfg=61 guibg=NONE ctermbg=NONE gui=italic cterm=italic
    hi htmlLink guifg=#3f83a6 ctermfg=67 guibg=NONE ctermbg=NONE gui=underline cterm=underline
    hi htmlSpecialChar guifg=#b6662d ctermfg=130 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
    hi htmlSpecialTagName guifg=#c57339 ctermfg=173 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
    hi htmlTag guifg=#3f83a6 ctermfg=67 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
    hi htmlTagN guifg=#2d539e ctermfg=25 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
    hi htmlTagName guifg=#c57339 ctermfg=173 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
    hi htmlTitle guifg=#c57339 ctermfg=173 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
