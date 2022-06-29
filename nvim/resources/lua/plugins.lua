vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)

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
    'neovim/nvim-lspconfig',
    'nvim-lua/lsp-status.nvim'
  }

  use {
    "ray-x/lsp_signature.nvim",
  }

  -- lsp stuff
  use {
      'nvim-treesitter/nvim-treesitter',
      run = ':TSUpdate',
      cmd = {'TSInstall', 'TSUpdate', 'TSInstallInfo'},
      config = function() require'config/treesitter' end,
      event = "bufEnter",
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

  use 'folke/lua-dev.nvim'

  use 'nvim-lua/lsp_extensions.nvim'

  use {
    "rafamadriz/friendly-snippets",
    event = "InsertEnter",
  }

  use {
    "hrsh7th/nvim-cmp",
    after = "friendly-snippets",
    config = function()
      require "config.cmp"
    end,
  }

  use {
    "hrsh7th/cmp-nvim-lua",
    after = "nvim-cmp",
  }

  use {
    "L3MON4D3/LuaSnip",
    wants = "friendly-snippets",
    after = "nvim-cmp",
    config = require("config.others").luasnip(),
  }

  use {
    "saadparwaiz1/cmp_luasnip",
    after = "LuaSnip",
  }

  use {
    "hrsh7th/cmp-nvim-lsp",
    after = "cmp-nvim-lua",
  }

  use {
    "rcarriga/nvim-notify",
    config = function()
      require("config.notify")
    end
  }

  use {
    "hrsh7th/cmp-buffer",
    after = "cmp-nvim-lsp",
  }

  use {
    "hrsh7th/cmp-path",
    after = "cmp-buffer",
  }

  use {
    'lewis6991/gitsigns.nvim',
    requires = {
      'nvim-lua/plenary.nvim'
    },
    config = function()
      require('gitsigns').setup()
    end
  }

  -- GitMessengeru
  use 'rhysd/git-messenger.vim'

  -- MultiCursor
  use 'mg979/vim-visual-multi'

  -- Pretty symbols
  use 'kyazdani42/nvim-web-devicons'

  -- Color scheme
  use {"ellisonleao/gruvbox.nvim", requires = {"rktjmp/lush.nvim"}}

  -- indent line
  use 'Yggdroot/indentLine'

  -- Tree
  use {
    'kyazdani42/nvim-tree.lua',
    -- cmd = {'NvimTreeFindFile', 'NvimTreeToggle', 'NvimTreeToggle'},
    requires = {
      'kyazdani42/nvim-web-devicons', -- optional, for file icons
    },
    tag = 'nightly', -- optional, updated every week. (see issue #1193)
    config = function ()
      require("config.tree")
    end
  }

  use {
    'nvim-lualine/lualine.nvim',
    requires = {
      {'kyazdani42/nvim-tree.lua', opt = false },
      {'arkav/lualine-lsp-progress', opt = false },
      {'kyazdani42/nvim-web-devicons', opt = true }
    }
  }



  -- Comments
  use {
    'terrortylor/nvim-comment',
    config = function()
      require('nvim_comment').setup({
        create_mappings = false,
      })
    end,
  }

end)
