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
    'onsails/lspkind-nvim', 'neovim/nvim-lspconfig',
    'nvim-lua/lsp-status.nvim'
  }

  use {
    "folke/lsp-trouble.nvim",
    config = function()
    -- Can use P to toggle auto movement
      require("trouble").setup {
        auto_preview = false,
        auto_fold = true,
      }
    end,
  }

  use 'glepnir/lspsaga.nvim'
  use 'folke/lua-dev.nvim'

  use 'nvim-lua/completion-nvim'

  use 'nvim-lua/lsp_extensions.nvim'

  -- Git
  use {
    {'tpope/vim-fugitive', cmd = {'Git', 'Gstatus', 'Gblame', 'Gpush', 'Gpull'}}, {
      'lewis6991/gitsigns.nvim',
      requires = {'nvim-lua/plenary.nvim'},
      setup = require('config.gitsigns'),
      event = 'BufEnter'
    }, {'TimUntersberger/neogit', opt = true}
  }

  -- GitMessengeru
  use 'rhysd/git-messenger.vim'

  -- MultiCursor
  use 'mg979/vim-visual-multi'

  -- Pretty symbols
  use 'kyazdani42/nvim-web-devicons'

  -- Color scheme
  use 'morhetz/gruvbox'

  -- indent line
  use 'Yggdroot/indentLine'

  -- Temporary
  use 'tjdevries/astronauta.nvim'

  -- statius line
  use 'tjdevries/express_line.nvim'

  -- Tree
  use 'kyazdani42/nvim-tree.lua'

end)
