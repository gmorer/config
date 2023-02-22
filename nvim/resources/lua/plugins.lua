return {
  "nvim-lua/plenary.nvim",

  -- "nyoom-engineering/oxocarbon.nvim",
  {
    "catppuccin/nvim",
    name = "catppuccin",
    opts = {
      flavour = "mocha",
      dim_inactive = {
        enabled = true,
        shade = "dark",
        percentage = 0.15,
      },
      integrations = {
        neotree = true,
        leap = true,
        gitsigns = true,
        noice = true,
        cmp = true,
        treesitter = true,
        telescope = true,
        lsp_trouble = true,
        native_lsp = {
          enabled = true,
          virtual_text = {
            errors = { "italic" },
            hints = { "italic" },
            warnings = { "italic" },
            information = { "italic" },
          },
          underlines = {
            errors = { "underline" },
            hints = { "underline" },
            warnings = { "underline" },
            information = { "underline" },
          },
        },
      },
    },
  },

  {
    "ggandor/leap.nvim",
    dependencies = {
      "tpope/vim-repeat"
    },
    init = function() require("leap").add_default_mappings() end
  },
  {
    "nvim-telescope/telescope.nvim",
    init = require("config.telescope").init,
    opts = require("config.telescope").opts,
    dependencies = "nvim-web-devicons"
  },
  "folke/neodev.nvim",

  "nvim-telescope/telescope-fzf-native.nvim",
  "nvim-telescope/telescope-media-files.nvim",
  "nvim-telescope/telescope-ui-select.nvim",

  -- Completion and linting
  "neovim/nvim-lspconfig",
  "nvim-lua/lsp-status.nvim",

  -- lsp stuff
  {
    "nvim-treesitter/nvim-treesitter",
    cmd = {"TSInstall", "TSUpdate", "TSInstallInfo"},
    opts = require("config.treesitter"),
    event = "bufEnter",
  },

  {
    "folke/lsp-trouble.nvim",
    -- Can use P to toggle auto movement
    opts = {
      auto_preview = false,
      auto_fold = true,
    },
  },

  "nvim-lua/lsp_extensions.nvim",


  {
    "hrsh7th/nvim-cmp",
    init = function () vim.opt.completeopt = "menuone,noselect" end,
    opts = require("config.cmp"),
    event = "InsertEnter",
    dependencies = {
      "saadparwaiz1/cmp_luasnip",
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-nvim-lua",
      "rafamadriz/friendly-snippets",
      "L3MON4D3/LuaSnip",
    }
  },

  {
    "L3MON4D3/LuaSnip",
    dependencies = "friendly-snippets",
    config = require("config.others").luasnip(),
    lazy = true,
  },


  -- git

  -- gitdiff
  {
    "sindrets/diffview.nvim",
    dependencies = "nvim-lua/plenary.nvim",
    cmd = {"DiffviewFileHistory", "DiffviewOpen"}
  },

  {
    "lewis6991/gitsigns.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function() require("gitsigns").setup() end
  },

  -- blame popup
  "rhysd/git-messenger.vim",

  -- MultiCursor
  "mg979/vim-visual-multi",

  -- Pretty symbols
  "kyazdani42/nvim-web-devicons",

  -- zen mode

  {
    "Pocco81/true-zen.nvim",
    cmd = { "TZAtaraxis", "TZFocus", "TZMinimalist", "TZNarrow"},
    opts = {
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
  },

  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v2.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "kyazdani42/nvim-web-devicons", -- not strictly required, but recommended
      "MunifTanjim/nui.nvim",
    },
    opts = require("config.tree"),
    cmd = "Neotree",
  },

  {
    "nvim-lualine/lualine.nvim",
    dependencies = {
      {"arkav/lualine-lsp-progress" },
      {"kyazdani42/nvim-web-devicons" }
    },
    opts = { options = { theme = "catppuccin" }}
  },

  {
    "b0o/incline.nvim",
    opts = require("config.incline"),
  },

  -- tabbar
  {
    "akinsho/bufferline.nvim",
    -- tag = "v2.*",
    dependencies = "kyazdani42/nvim-web-devicons",
    opts = {
      options = {
        -- modified_icon = "●",
        always_show_bufferline = false,
        mode = "tabs",
        indicator = {
          style = "underline",
        },
        offsets = {
          {filetype = "NvimTree", text = "File Explorer", text_align = "left", padding = 1},
          {filetype = "neo-tree", text = "File Explorer", text_align = "left"},
        },
      }
    }
  },

  "Yggdroot/indentLine",

  -- Comments
  {
    "terrortylor/nvim-comment",
    init = function ()
      require('nvim_comment').setup({
        create_mappings = false,
      })
    end
  },

  -- Command line
  {
    "folke/noice.nvim",
    event = "VimEnter",
    init = function()
      require("telescope").load_extension("noice")
    end,
    opts = require("config.noice"),
    dependencies = {
      "nvim-telescope/telescope.nvim",
      "hrsh7th/nvim-cmp",
      "MunifTanjim/nui.nvim",
    }
  }
}
