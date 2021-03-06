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
  set clipboard=unnamed " copy from vim paste into system using * register
  set grepprg=rg\ --smart-case\ --vimgrep
  set tabstop=2 " 2 spaces for a tab
  set shiftwidth=2
  set softtabstop=2
  set expandtab
  set termguicolors
  set laststatus=2
  set statusline=%m%t
  set statusline+=%=\ 
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
  set scrolloff=8
  set sidescrolloff=30
  set splitright
  set clipboard=unnamedplus
  set nowrap
  " set titlestring=%(\ %M%)%(\ %M%)%(\ %M%)%(\ %M%)%(\ %M%)%(_____\ %)%t%(\ _____(%{expand(\"%:~:h\")})%)%(\ %a%)
  set startofline
  " disable continuation of comment on next line when hit 'o'
    set formatoptions-=cro
  set foldmethod=indent
  set nofoldenable

" --------
" Key Maps
" --------
  nnoremap <SPACE> <Nop>
  let mapleader=" "
  map <leader>p :CtrlP<CR>
  map <leader>b :CtrlPBuffer<CR>
  map <leader>f :Files!<CR>
  map <leader>r :Rg!<CR>
  map <c-h> <c-w>wh
  map <c-j> <c-w>wj
  map <c-k> <c-w>wk
  map <c-l> <c-w>wl
  map <leader>W :set wrap!<CR>
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
  " Quickly escape to normal mode
    imap jj <esc>
  nnoremap <expr> <leader>t g:NERDTree.IsOpen() ? ':NERDTreeClose<CR>' : @% == '' ? ':NERDTree<CR>' : ':NERDTreeFind<CR>'
  nmap <leader>T :NERDTreeFind<CR>
  map <leader>d :ToggleDiag<CR>
  map <leader>] <c-]>
  map <leader>[ <c-t>
  map <leader>, :bp<CR>
  map <leader>. :bn<CR>
  map <leader>w :wa<CR>
  map <leader>q :q<CR>
  map <leader>Q :qa!<CR>
  nnoremap q: <nop>
  nnoremap Q <nop>
  map <leader>s :setlocal spell! spelllang=en_us<CR>
  map <leader>1 :windo set wrap!<CR>
  nmap <leader>} <Plug>(GitGutterNextHunk)
  nmap <leader>{ <Plug>(GitGutterPrevHunk)

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
      Plug 'neovim/nvim-lspconfig'
      Plug 'WhoIsSethDaniel/toggle-lsp-diagnostics.nvim'
    call plug#end()
  " git gutter
    let g:gitgutter_diff_base = 'HEAD'
    let g:gitgutter_diff_base = 'f63a965181eb56bd9d459c9e8bd861bce0867633'
    let g:gitgutter_enabled = 0
    let g:fzf_preview_window = ['up:40%:hidden', 'ctrl-/']
  " fzf
    " Customise the Files command to use rg which respects .gitignore files
      command! -bang -nargs=? -complete=dir Files call fzf#run(fzf#wrap('files', fzf#vim#with_preview({ 'dir': <q-args>, 'sink': 'e', 'source': 'rg --files --hidden' }), <bang>0))
    " Add an AllFiles variation that ignores .gitignore files
      command! -bang -nargs=? -complete=dir AllFiles call fzf#run(fzf#wrap('allfiles', fzf#vim#with_preview({ 'dir': <q-args>, 'sink': 'e', 'source': 'rg --files --hidden --no-ignore' }), <bang>0))
    " Ignore matches in filenames when using Rg
      command! -bang -nargs=* Rg call fzf#vim#grep("rg --column --line-number --no-heading --color=always --smart-case ".shellescape(<q-args>), 1, fzf#vim#with_preview({'options': '--delimiter : --nth 4..'}), <bang>0)
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
    indent = {
      enable = true,
    }
  }
EOF
" colorizer
lua <<EOF
  require'colorizer'.setup()
EOF
" lua << EOF
"   require'lspconfig'.solargraph.setup{}
" EOF
lua <<EOF
  require'lspconfig'.eslint.setup{}
EOF

" lspconfig
lua << EOF
local nvim_lsp = require('lspconfig')

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  -- Enable completion triggered by <c-x><c-o>
  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  local opts = { noremap=true, silent=true }

  -- See `:help vim.lsp.*` for documentation on any of the below functions
  buf_set_keymap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  buf_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
  buf_set_keymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
  buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  buf_set_keymap('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
  buf_set_keymap('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  buf_set_keymap('n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  buf_set_keymap('n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  buf_set_keymap('n', '<space>e', '<cmd>lua vim.diagnostic.open_float()<CR>', opts)
  buf_set_keymap('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
  buf_set_keymap('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)
  buf_set_keymap('n', '<space>q', '<cmd>lua vim.diagnostic.setloclist()<CR>', opts)
  -- buf_set_keymap('n', '<space>f', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)
  buf_set_keymap('n', '<space>o', '<cmd>lua vim.diagnostic.open_float()<CR>', opts)
end

-- Use a loop to conveniently call 'setup' on multiple servers and
-- map buffer local keybindings when the language server attaches
local servers = { 'solargraph', 'denols', 'clangd' }
for _, lsp in ipairs(servers) do
  nvim_lsp[lsp].setup {
    on_attach = on_attach,
    flags = {
      debounce_text_changes = 150,
    }
  }
end

EOF
" lsp diagnostics
lua <<EOF
  require'toggle_lsp_diagnostics'.init({ start_on = false })
EOF

" -------------------
" Syntax Highlighting
" -------------------
  hi clear
  if exists('syntax_on')
    syntax reset
  endif

  hi Normal ctermbg=254 ctermfg=237 guibg=#e8e9ec guifg=#393d52
  hi ColorColumn cterm=NONE ctermbg=253 ctermfg=NONE guibg=#dcdfe7 guifg=NONE
  hi CursorColumn cterm=NONE ctermbg=253 ctermfg=NONE guibg=#dedede guifg=NONE
  hi CursorLine cterm=NONE ctermbg=253 ctermfg=NONE guibg=#cbcfda guifg=NONE
  hi Comment ctermfg=244 guifg=#8389a3
  hi Conceal ctermbg=254 ctermfg=244 guibg=#e8e9ec guifg=#8389a3
  hi Constant ctermfg=97 guifg=#7759b4
  hi Cursor ctermbg=237 ctermfg=254 guibg=#393d52 guifg=#e8e9ec
  hi CursorLineNr cterm=NONE ctermbg=251 ctermfg=237 guibg=NONE guifg=#cc517a " changed
  hi Delimiter ctermfg=237 guifg=#393d52
  hi DiffAdd ctermbg=79 ctermfg=23 guibg=#d4dbd1 guifg=#475946
  hi DiffChange ctermbg=116 ctermfg=24 guibg=#ced9e1 guifg=#375570
  hi DiffDelete cterm=NONE ctermbg=181 ctermfg=89 gui=NONE guibg=#e3d2da guifg=#70415e
  hi DiffText cterm=NONE ctermbg=73 ctermfg=24 gui=NONE guibg=#acc5d3 guifg=#393d52
  hi Directory ctermfg=31 guifg=#327698
  hi Error ctermbg=254 ctermfg=125 guibg=#e8e9ec guifg=#cc517a
  hi ErrorMsg ctermbg=254 ctermfg=125 guibg=#e8e9ec guifg=#cc517a
  hi WarningMsg ctermbg=254 ctermfg=125 guibg=#e8e9ec guifg=#cc517a
  hi EndOfBuffer ctermfg=251 guifg=#cbcfda
  hi NonText ctermfg=251 guifg=#cbcfda
  hi Whitespace ctermfg=251 guifg=#cbcfda
  hi Folded ctermbg=253 ctermfg=243 guibg=#dcdfe7 guifg=#788098
  hi FoldColumn ctermbg=253 ctermfg=248 guibg=#dcdfe7 guifg=#9fa7bd
  hi Function ctermfg=25 guifg=#2d539e
  hi Identifier cterm=NONE ctermfg=31 guifg=#327698
  hi Ignore ctermbg=NONE ctermfg=NONE guibg=NONE guifg=NONE
  hi Include ctermfg=25 guifg=#2d539e
  hi IncSearch cterm=reverse ctermfg=NONE gui=reverse guifg=NONE term=reverse
  hi LineNr ctermbg=253 ctermfg=248 guibg=NONE guifg=#c57339 " changed
  hi MatchParen ctermbg=250 ctermfg=0 guibg=#bec0c9 guifg=#393d52
  hi ModeMsg ctermfg=244 guifg=#8389a3
  hi MoreMsg ctermfg=64 guifg=#668e3d
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
  hi Special ctermfg=64 guifg=#668e3d
  hi SpecialKey ctermfg=248 guifg=#a5b0d3
  hi SpellBad ctermbg=181 ctermfg=237 gui=undercurl guifg=NONE guisp=#cc517a
  hi SpellCap ctermbg=117 ctermfg=237 gui=undercurl guifg=NONE guisp=#2d539e
  hi SpellLocal ctermbg=116 ctermfg=237 gui=undercurl guifg=NONE guisp=#327698
  hi SpellRare ctermbg=110 ctermfg=237 gui=undercurl guifg=NONE guisp=#7759b4
  hi Statement ctermfg=25 gui=NONE guifg=#2d539e
  hi StatusLine cterm=reverse ctermbg=252 ctermfg=243 gui=reverse guibg=#c57339 guifg=#eac6ad term=reverse
  hi StatusLineTerm cterm=reverse ctermbg=252 ctermfg=243 gui=reverse guibg=#c57339 guifg=#eac6ad term=reverse
  hi StatusLineNC cterm=reverse ctermbg=244 ctermfg=251 gui=reverse guibg=#393d52 guifg=#dedede
  hi StatusLineTermNC cterm=reverse ctermbg=244 ctermfg=251 gui=reverse guibg=#393d52 guifg=#e8e9ec
  hi StorageClass ctermfg=25 guifg=#2d539e
  hi String ctermfg=31 guifg=#327698
  hi Structure ctermfg=25 guifg=#2d539e
  hi TabLine cterm=NONE ctermbg=251 ctermfg=244 gui=NONE guibg=#cad0de guifg=#8b98b6
  hi TabLineFill cterm=reverse ctermbg=244 ctermfg=251 gui=reverse guibg=#8b98b6 guifg=#cad0de
  hi TabLineSel cterm=NONE ctermbg=254 ctermfg=237 gui=NONE guibg=#e8e9ec guifg=#606374
  hi TermCursorNC ctermbg=244 ctermfg=254 guibg=#8389a3 guifg=#e8e9ec
  hi Title ctermfg=130 gui=NONE guifg=#c57339
  hi Todo ctermbg=254 ctermfg=64 guibg=#d4dbd1 guifg=#668e3d
  hi Type ctermfg=25 gui=NONE guifg=#2d539e
  hi Underlined cterm=underline ctermfg=25 gui=underline guifg=#2d539e term=underline
  hi VertSplit cterm=NONE ctermbg=251 ctermfg=251 gui=NONE guibg=#eac6ad guifg=#eac6ad
  hi Visual ctermbg=251 ctermfg=NONE guibg=#c9cdd7 guifg=NONE
  hi VisualNOS ctermbg=251 ctermfg=NONE guibg=#c9cdd7 guifg=NONE
  hi WildMenu ctermbg=235 ctermfg=252 guibg=#32364c guifg=#e8e9ec
  hi icebergNormalFg ctermfg=237 guifg=#393d52
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
  hi GitGutterChange ctermbg=253 ctermfg=31 guibg=#dcdfe7 guifg=#327698
  hi GitGutterChangeDelete ctermbg=253 ctermfg=31 guibg=#dcdfe7 guifg=#327698
  hi GitGutterDelete ctermbg=253 ctermfg=125 guibg=#dcdfe7 guifg=#cc517a
  hi gitmessengerEndOfBuffer ctermbg=253 ctermfg=248 guibg=#dcdfe7 guifg=#9fa7bd
  hi gitmessengerPopupNormal ctermbg=253 ctermfg=237 guibg=#dcdfe7 guifg=#393d52
  hi Sneak ctermbg=97 ctermfg=254 guibg=#7759b4 guifg=#e8e9ec
  hi SneakScope ctermbg=251 ctermfg=244 guibg=#c9cdd7 guifg=#8389a3
  hi SyntasticErrorSign ctermbg=253 ctermfg=125 guibg=#dcdfe7 guifg=#cc517a
  hi SyntasticStyleErrorSign ctermbg=253 ctermfg=125 guibg=#dcdfe7 guifg=#cc517a
  hi SyntasticStyleWarningSign ctermbg=253 ctermfg=130 guibg=#dcdfe7 guifg=#c57339
  hi SyntasticWarningSign ctermbg=253 ctermfg=130 guibg=#dcdfe7 guifg=#c57339
  hi ZenSpace ctermbg=125 guibg=#cc517a
  hi icebergALAccentRed ctermfg=125 guifg=#cc517a
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
  let g:terminal_color_14 = '#327698'
  let g:terminal_color_15 = '#262a3f'

  "TS Settings"
  hi TSComment ctermfg=244 guifg=#8389a3
  hi TSError guifg=#cc3768 ctermfg=167 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
  hi TSPunctDelimiter guifg=#8389a3 ctermfg=97 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
  hi TSPunctBracket guifg=#8389a3 ctermfg=97 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
  hi TSPunctSpecial guifg=#8389a3 ctermfg=97 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
  hi TSConstant guifg=#cc517a ctermfg=173 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
  hi TSConstBuiltin guifg=#327698 ctermfg=25 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
  hi TSConstMacro guifg=#598030 ctermfg=65 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
  hi TSStringRegex guifg=#b6662d ctermfg=130 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
  hi TSString guifg=#c57339 ctermfg=130 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
  hi TSStringEscape guifg=#b6662d ctermfg=130 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
  hi TSCharacter guifg=#b6662d ctermfg=130 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
  hi TSNumber guifg=#393d52 ctermfg=65 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
  hi TSBoolean guifg=#7759b4 ctermfg=25 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
  hi TSFloat guifg=#668e3d ctermfg=65 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
  hi TSAnnotation guifg=#c57339 ctermfg=173 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
  hi TSAttribute guifg=#598030 ctermfg=65 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
  hi TSNamespace guifg=#598030 ctermfg=65 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
  hi TSFuncBuiltin guifg=#c57339 ctermfg=173 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
  hi TSFunction ctermfg=237 guifg=#327698
  hi TSFuncMacro guifg=#c57339 ctermfg=173 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
  hi TSParameter guifg=#393d52 ctermfg=25 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
  hi TSParameterReference guifg=#327698 ctermfg=25 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
  hi TSMethod ctermfg=237 guifg=#327698
  hi TSField guifg=#393d52 ctermfg=25 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
  hi TSProperty guifg=#393d52 ctermfg=25 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
  hi TSConstructor guifg=#327698 ctermfg=65 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
  hi TSConditional guifg=#7759b4 ctermfg=61 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
  hi TSRepeat guifg=#7759b4 ctermfg=61 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
  hi TSLabel guifg=#393d52 ctermfg=243 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
  hi TSKeyword guifg=#7759b4 ctermfg=97 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
  hi TSKeywordFunction guifg=#7759b4 ctermfg=61 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
  hi TSKeywordOperator guifg=#7759b4 ctermfg=25 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
  hi TSOperator guifg=#7759b4 ctermfg=97 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
  hi TSException guifg=#7759b4 ctermfg=61 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
  hi TSType guifg=#668e3d ctermfg=65 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
  hi TSTypeBuiltin guifg=#327698 ctermfg=25 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
  hi TSStructure guifg=#ff00ff ctermfg=201 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
  hi TSInclude guifg=#7759b4 ctermfg=61 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
  hi TSVariable guifg=#393d52 ctermfg=243 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
  hi TSVariableBuiltin guifg=#327698 ctermfg=25 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
  hi TSText guifg=#ffff00 ctermfg=226 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
  hi TSStrong guifg=#ffff00 ctermfg=226 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
  hi TSEmphasis guifg=#ffff00 ctermfg=226 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
  hi TSUnderline guifg=#ffff00 ctermfg=226 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
  hi TSTitle guifg=#ffff00 ctermfg=226 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
  hi TSLiteral guifg=#b6662d ctermfg=130 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
  hi TSURI cterm=underline ctermfg=31 gui=underline guifg=#2d539e term=underline
  hi TSTag guifg=#7759b4 ctermfg=25 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
  hi TSTagDelimiter guifg=#8389a3 ctermfg=237 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
  hi TSQueryLinterError guifg=#ff8800 ctermfg=208 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
  hi TSSymbol guifg=#cc517a ctermfg=168 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
  hi TSFunctionBuiltin ctermfg=237 guifg=#505695
  hi TSFunctionMacro ctermfg=237 guifg=#505695

  hi htmlArg guifg=#b6662d ctermfg=130 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
  hi htmlBold guifg=#b6662d ctermfg=130 guibg=NONE ctermbg=NONE gui=bold cterm=bold
  hi htmlEndTag guifg=#2d539e ctermfg=67 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
  hi htmlH1 guifg=#262a3f ctermfg=236 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
  hi htmlH2 guifg=#262a3f ctermfg=236 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
  hi htmlH3 guifg=#262a3f ctermfg=236 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
  hi htmlH4 guifg=#262a3f ctermfg=236 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
  hi htmlH5 guifg=#262a3f ctermfg=236 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
  hi htmlH6 guifg=#262a3f ctermfg=236 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
  hi htmlItalic guifg=#6845ad ctermfg=61 guibg=NONE ctermbg=NONE gui=italic cterm=italic
  hi htmlLink guifg=#2d539e ctermfg=67 guibg=NONE ctermbg=NONE gui=underline cterm=underline
  hi htmlSpecialChar guifg=#b6662d ctermfg=130 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
  hi htmlSpecialTagName guifg=#c57339 ctermfg=173 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
  hi htmlTag guifg=#2d539e ctermfg=67 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
  hi htmlTagN guifg=#2d539e ctermfg=25 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
  hi htmlTagName guifg=#c57339 ctermfg=173 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
  hi htmlTitle guifg=#c57339 ctermfg=173 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE

  hi LspDiagnosticsUnderline guifg=#7759b4 ctermfg=61 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
  hi LspDiagnosticsInformation guifg=#7759b4 ctermfg=61 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
  hi LspDiagnosticsHint guifg=#7759b4 ctermfg=61 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
  hi LspDiagnosticsError guifg=#7759b4 ctermfg=61 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
  hi LspDiagnosticsWarning guifg=#7759b4 ctermfg=61 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
  hi LspDiagnosticsUnderlineError guifg=#7759b4 ctermfg=61 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
  hi LspDiagnosticsUnderlineHint guifg=#7759b4 ctermfg=61 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
  hi LspDiagnosticsUnderlineInformation guifg=#7759b4 ctermfg=61 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
  hi LspDiagnosticsUnderlineWarning guifg=#7759b4 ctermfg=61 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
  hi LspReferenceText guifg=#7759b4 ctermfg=61 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
  hi LspReferenceRead guifg=#7759b4 ctermfg=61 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
  hi LspReferenceWrite guifg=#7759b4 ctermfg=61 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
  hi LspCodeLens guifg=#7759b4 ctermfg=61 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
  hi LspCodeLensSeparator guifg=#7759b4 ctermfg=61 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
  hi LspSignatureActiveParameter guifg=#7759b4 ctermfg=61 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
