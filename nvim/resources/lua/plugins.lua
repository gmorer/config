vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function()

  -- use himself
  use 'wbthomason/packer.nvim'

   -- Search
  use {
    'nvim-telescope/telescope.nvim',
    requires = {{'nvim-lua/popup.nvim'}, {'nvim-lua/plenary.nvim'}},
    config = require('config.telescope'),
    cmd = 'Telescope'
  }

  use {'nvim-telescope/telescope-frecency.nvim', requires = 'tami5/sql.nvim'}

  -- Completion and linting
  use {
    'onsails/lspkind-nvim', 'neovim/nvim-lspconfig', 'nvim-lua/lsp-status.nvim',
    'glepnir/lspsaga.nvim', 'folke/trouble.nvim'
  }
  use 'folke/lua-dev.nvim'

  use 'nvim-lua/completion-nvim'


  -- Git
  use {
    {'tpope/vim-fugitive', cmd = {'Git', 'Gstatus', 'Gblame', 'Gpush', 'Gpull'}}, {
      'lewis6991/gitsigns.nvim',
      requires = {'nvim-lua/plenary.nvim'},
      setup = require('config.gitsigns'),
      event = 'BufEnter'
    }, {'TimUntersberger/neogit', opt = true}
  }

  -- Pretty symbols
  use 'kyazdani42/nvim-web-devicons'

  -- Color scheme
  use 'hardselius/warlock'
  use 'arzg/vim-substrata'
  use 'sainnhe/gruvbox-material'
  vim.opt.termguicolors = true
  vim.opt.background = 'dark'
  vim.api.nvim_set_var('gruvbox_material_palette', 'original')
  vim.cmd [[colorscheme gruvbox-material]]

end)
