require('packer').startup(function()
  use 'wbthomason/packer.nvim'

  use 'norcalli/nvim-colorizer.lua'

  use {
    'nvim-treesitter/nvim-treesitter',
    run = ':TSUpdate'
  }

  use 'aphivantrakul/nvcode-color-schemes.vim'

  use 'ctrlpvim/ctrlp.vim'
end)

require('plugin_configs')

require('colorizer').setup()
