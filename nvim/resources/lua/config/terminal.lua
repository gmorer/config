local opts = {buffer = 0}

vim.keymap.set('t', '<C-j>', [[<Cmd>wincmd j<CR>]], opts)
vim.keymap.set('t', '<C-k>', [[<Cmd>wincmd k<CR>]], opts)

require("toggleterm").setup{
    direction = 'tab',
    open_mapping = [[c-`]],
}
