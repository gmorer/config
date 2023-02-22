vim.opt.termguicolors = true

vim.o.background = "dark"

-- vim.g.oxocarbon_lua_keep_terminal = true
-- vim.g.oxocarbon_lua_alternative_telescope = true

-- vim.cmd([[colorscheme oxocarbon]])
vim.cmd([[colorscheme catppuccin]])

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

vim.opt.fillchars = {
  diff = "╱",
}

-- Telescope default theme is better than the oxocarbon one
vim.api.nvim_set_hl(0, "TelescopeBorder", {link = "Normal"})
vim.api.nvim_set_hl(0, "TelescopePromptBorder", {link = "Normal"})
vim.api.nvim_set_hl(0, "TelescopePromptNormal", {link = "Normal"})
vim.api.nvim_set_hl(0, "TelescopePromptPrefix", {link = "Normal"})
vim.api.nvim_set_hl(0, "TelescopeNormal", {link = "Normal"})
vim.api.nvim_set_hl(0, "TelescopePreviewTitle", {link = "Normal"})
vim.api.nvim_set_hl(0, "TelescopePromptTitle", {link = "Normal"})
vim.api.nvim_set_hl(0, "TelescopeResultsTitle", {link = "Normal"})
-- vim.api.nvim_set_hl(0, "TelescopeSelection", {link = "Normal"})
vim.api.nvim_set_hl(0, "TelescopePreviewLine", {link = "Normal"})
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
    if vim.bo.filetype == "" then
      vim.cmd("IndentLinesDisable")
    end
  end,
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
