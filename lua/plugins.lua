require('packer').startup(function()
  use 'wbthomason/packer.nvim'

  use 'norcalli/nvim-colorizer.lua'

  use {
    'nvim-treesitter/nvim-treesitter',
    run = ':TSUpdate'
  }

  use 'aphivantrakul/nvcode-color-schemes.vim'

  use 'ctrlpvim/ctrlp.vim'

  use {'junegunn/fzf', dir = '~/.fzf', run = './install --all' }
	use {'junegunn/fzf.vim'}

  use {'airblade/vim-rooter'}
end)

require('plugin_configs')

require('colorizer').setup()
