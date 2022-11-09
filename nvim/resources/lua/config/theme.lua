vim.opt.termguicolors = true
-- vim.opt.background = 'dark'
-- vim.o.background = "dark"

vim.g.oxocarbon_lua_keep_terminal = true
vim.g.oxocarbon_lua_alternative_telescope = true
vim.cmd([[colorscheme oxocarbon-lua]])

vim.opt.list = true
-- vim.opt.list = false
vim.opt.listchars = {
  -- eol = "⏎",
  tab = '┊ ',
  trail = "●",
  nbsp = "⎵",
  extends = "…",
  precedes = "…"
}
-- vim.o.scrolloff=5

-- Hide statusline by setting laststatus and cmdheight to 0.
-- vim.o.laststatus=3
-- vim.o.cmdheight=0

-- Set the winbar to the statusline.
-- vim.o.winbar = vim.o.statusline

-- With vertical splits, the statusline would still show up at the
-- bottom of the split. A quick fix is to just set the statusline
-- to empty whitespace (it can't be an empty string because then
-- it'll get replaced by the default stline).
-- vim.o.statusline = " "vim.o
--
    vim.api.nvim_set_var('indentLine_char', '┊')
    vim.api.nvim_set_var('indentLine_showFirstIndentLevel', 0)
    vim.api.nvim_set_var('indentLine_first_char', '┊')

-- Disable mouse
vim.o.mouse=""

-- does not work with filetype
vim.api.nvim_create_autocmd("BufEnter", {
  pattern = {"*"},
  callback = function ()
    if vim.bo.filetype == "mind" then
      vim.o.relativenumber = false
    end
  end
})

vim.api.nvim_create_autocmd("TermOpen", {
  callback = function ()
    vim.cmd('IndentLinesDisable')
    vim.cmd('setlocal listchars= nonumber norelativenumber nocursorline nolist')
  end
})

vim.api.nvim_create_autocmd("TermOpen", {
  pattern = '',
  command = 'startinsert'
})

vim.api.nvim_create_autocmd("BufEnter", {
  pattern = "term://*",
  command = 'startinsert'
})

-- vim.cmd('autocmd FileType mind setlocal nonumber norelativenumber')
