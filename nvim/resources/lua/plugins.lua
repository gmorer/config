vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)

  -- use himself
  use 'wbthomason/packer.nvim'
  use 'nvim-lua/plenary.nvim'

  -- Search
  --[[
  use {
    'nvim-telescope/telescope.nvim',
    requires = {{'nvim-lua/popup.nvim'}, {'nvim-lua/plenary.nvim'}},
    config = require('config.telescope'),
    cmd = 'Telescope'
  }
  --]]

  -- use {'nvim-telescope/telescope-frecency.nvim', requires = 'tami5/sql.nvim'}
  use {
    "nvim-telescope/telescope.nvim",
    config = require('config.telescope'),
    after = "nvim-web-devicons"
  }
  -- has to be before lspconfig
  use {
    "folke/neodev.nvim",
  }

  use { "nvim-telescope/telescope-fzf-native.nvim", run = "make" }
  use { "nvim-telescope/telescope-media-files.nvim" }
  use { "nvim-telescope/telescope-ui-select.nvim" }
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
    config = function() require('gitsigns').setup()
    end
  }

  -- GitMessengeru
  use 'rhysd/git-messenger.vim'

  -- MultiCursor
  use 'mg979/vim-visual-multi'

  -- Pretty symbols
  use 'kyazdani42/nvim-web-devicons'

  -- Theme
  -- use 'navarasu/onedark.nvim'
  use 'B4mbus/oxocarbon-lua.nvim'

  -- indent line
  use 'Yggdroot/indentLine'

  use {
    'levouh/tint.nvim',
    config = function()
      require('tint').setup()
    end
  }

  -- zen mode

  use({
    "Pocco81/true-zen.nvim",
    config = function()
      require("true-zen").setup {
        integrations = {
          lualine = true,
          kitty = {
            enabled = true,
            font = "+3",
          },
        },
        modes = {
          narrow = {
            folds_style = "invisible",
          },
        },
      }
    end,
  })

  -- Mind
  use {
    'phaazon/mind.nvim',
    branch = 'master',
    requires = { 'nvim-lua/plenary.nvim' },
    config = function()
      require'mind'.setup()
    end
  }

  -- Tree
  --[[
  use {
    'kyazdani42/nvim-tree.lua',
    -- cmd = {'NvimTreeFindFile', 'NvimTreeToggle', 'NvimTreeToggle'},
    requires = {
      'kyazdani42/nvim-web-devicons', -- optional, for file icons
    },
    -- tag = 'nightly', -- optional, updated every week. (see issue #1193)
    config = function ()
      require("config.tree")
    end
  }
  --]]
  use {
  "nvim-neo-tree/neo-tree.nvim",
    branch = "v2.x",
    requires = {
      "nvim-lua/plenary.nvim",
      "kyazdani42/nvim-web-devicons", -- not strictly required, but recommended
      "MunifTanjim/nui.nvim",
    },
    config = function()
      require('config.tree')
    end
  }

  use {
    'nvim-lualine/lualine.nvim',
    requires = {
      {'arkav/lualine-lsp-progress', opt = false },
      {'kyazdani42/nvim-web-devicons', opt = true }
    }
  }

  -- tabbar
  use {
    'akinsho/bufferline.nvim',
    tag = "v2.*",
    requires = 'kyazdani42/nvim-web-devicons',
    config = function()
      require("bufferline").setup{
        options = {
          -- modified_icon = '●',
          always_show_bufferline = true,
          mode = 'tabs',
          indicator = {
            style = 'underline',
          },
          offsets = {
            {filetype = "NvimTree", text = "File Explorer", text_align = "left", padding = 1},
            {filetype = "neo-tree", text = "File Explorer", text_align = "left"},
            {filetype = "mind", text = "mind.nvim", text_align = "center"}
        },
      }
    }
    end,
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

  -- Command line
  use({
    "folke/noice.nvim",
    event = "VimEnter",
    config = function()
      require("config.noice")
      require("noice").setup()
    end,
    requires = {
      "nvim-telescope/telescope.nvim",
      "MunifTanjim/nui.nvim",
      }
  })

end)
