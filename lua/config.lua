vim.cmd[[colorscheme iceberg]]
vim.o.termguicolors = true
vim.o.expandtab = true
vim.o.tabstop = 2
vim.o.shiftwidth = 2
vim.o.softtabstop = 2
vim.o.hlsearch = false
vim.o.number = true
vim.o.relativenumber = true
vim.cmd[[autocmd InsertEnter * :set norelativenumber]]
vim.cmd[[autocmd InsertLeave * :set number relativenumber]]
vim.o.path = '.,,,**'
vim.o.hidden = true
vim.cmd[[let g:netrw_fastbrowse = 0]]
vim.o.ignorecase = true
vim.o.smartcase = true
vim.cmd[[set wildignore+=*/node_modules/*,*/tmp/*,*/public/*]]
vim.o.clipboard = 'unnamed'
vim.cmd[[set grepprg=rg\ --smart-case\ --vimgrep]]
vim.o.linebreak = true
vim.wo.foldmethod = 'indent'
vim.o.foldenable = false
vim.o.title = true
vim.g.mapleader = ' '
vim.o.cursorline = true
vim.o.cursorcolumn = true
vim.cmd"let g:fzf_preview_window = ['up:40%:hidden', 'ctrl-/']"
