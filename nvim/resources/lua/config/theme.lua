vim.opt.termguicolors = true
-- vim.opt.background = 'dark'
-- vim.o.background = "dark"
vim.g.oxocarbon_lua_keep_terminal = true
vim.g.oxocarbon_lua_alternative_telescope = true
vim.cmd([[colorscheme oxocarbon-lua]])
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
vim.o.scrolloff=5


vim.api.nvim_set_var('indentLine_char', '┊')
vim.api.nvim_set_var('indentLine_showFirstIndentLevel', 0)
vim.api.nvim_set_var('indentLine_first_char', '┊')

