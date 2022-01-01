require('packer').startup(function()
  use 'wbthomason/packer.nvim'

  use {
    'nvim-treesitter/nvim-treesitter',
    run = ':TSUpdate'
  }

  --use 'rmehri01/onenord.nvim'

  --use 'EdenEast/nightfox.nvim'

  --use 'Mofiqul/vscode.nvim'

  --use 'marko-cerovac/material.nvim'

  --use "projekt0n/github-nvim-theme"

  --use 'yashguptaz/calvera-dark.nvim'

  --use({
  --  "catppuccin/nvim",
  --  s = "catppuccin"
  --})

  --use 'titanzero/zephyrium'

  use 'aphivantrakul/nvcode-color-schemes.vim'

  use 'norcalli/nvim-colorizer.lua'
end)

require('plugin_configs')

--require('onenord').setup({
--  theme = 'dark',
--})

--require('nightfox').load('nightfox')

--vim.g.vscode_style = "dark"
--vim.cmd[[colorscheme vscode]]

--vim.g.material_style = "deep ocean"
--vim.cmd 'colorscheme material'

--require('github-theme').setup()

--require('calvera').set()

--vim.cmd[[colorscheme catppuccin]]

--require 'zephyrium'

require('nvim-treesitter.configs').setup({
  ensure_installed = "all", -- one of "all", "maintained" (parsers with maintainers), or a list of languages
  highlight = {
    enable = true,              -- false will disable the whole extension
    disable = { "c", "rust" },  -- list of language that will be disabled
  },
  playground = {
    enable = true,
    disable = {},
    keymaps = {
      open = 'gtd' -- Opens the playground for current buffer (if applicable)
    },
    updatetime = 25 -- Debounced time for highlighting nodes in the playground from source code
  }
})

vim.cmd[[colorscheme iceberg]]

require'colorizer'.setup()
