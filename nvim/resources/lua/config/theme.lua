vim.opt.termguicolors = true
vim.opt.background = 'dark'
vim.o.background = "dark"
vim.cmd([[colorscheme onedark]])
vim.opt.list = true
vim.opt.laststatus = 3
vim.opt.listchars = {
  -- eol = "⏎",
  tab = '┊ ',
  trail = "●",
  nbsp = "⎵",
  extends = "…",
  precedes = "…"
}

vim.api.nvim_set_var('indentLine_char', '┊')
vim.api.nvim_set_var('indentLine_showFirstIndentLevel', 0)
vim.api.nvim_set_var('indentLine_first_char', '┊')

require('onedark').setup {
    style = 'darker'
}
require('onedark').load()
