vim.opt.termguicolors = true
vim.opt.background = 'dark'
vim.o.background = "dark"
vim.cmd([[colorscheme gruvbox]])
vim.opt.list = true
vim.opt.listchars = {
  eol = "⏎",
  tab = '┊ ',
  trail = "●",
  nbsp = "⎵",
  extends = "…",
  precedes = "…"
}

vim.api.nvim_set_var('indentLine_char', '┊')
vim.api.nvim_set_var('indentLine_showFirstIndentLevel', 1)
vim.api.nvim_set_var('indentLine_first_char', '┊')
