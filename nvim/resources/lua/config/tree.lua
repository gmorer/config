--[[
require("nvim-tree").setup({
  actions = {
    open_file = {
      quit_on_open = true,
    }
  },
  git = {
    enable = true,
    ignore = true,
    timeout = 400,
  },
  renderer = {
    highlight_git = false,
    highlight_opened_files = "name",

    indent_markers = {
      enable = true,
      icons = {
        corner = "└ ",
        edge = "│ ",
        item = "│ ",
        none = "  ",
      }
    }
  },
  filesystem_watchers = {
    enable = true,
  },
  view = {
    hide_root_folder = true,
    signcolumn = 'no',
  }
})
--]]
return {
  window = {
    mappings = {
      ["<tab>"] = "open",
    },
  },
}
