local dfl_opt = { noremap = true, silent = true }

-- nnoremap <C-n> :NvimTreeToggle<CR>
-- vim.api.nvim_set_keymap('', '<C-n>', ':NvimTreeFindFileToggle<CR>', dfl_opt)
vim.api.nvim_set_keymap('', '<C-n>', ':Neotree toggle filesystem left reveal<CR>', dfl_opt)
vim.api.nvim_set_keymap('n', '<S-T>', ':lua require"telescope.builtin".buffers{}<CR>', dfl_opt)

-- nnoremap <Leader>s :<C-u> :Git blame<CR>
vim.api.nvim_set_keymap('', '<Leader>s', ':<C-u> : GitMessenger<CR>', dfl_opt)

vim.api.nvim_set_keymap('', '<C-/>', ':CommentToggle<CR>', dfl_opt)

vim.api.nvim_set_var('VM_maps', {['Find Under'] = '<C-d>', ['Find Subword Under'] = '<C-d>'})

vim.api.nvim_set_keymap('t', '<C-`>', '<C-\\><C-n>', dfl_opt)
vim.api.nvim_set_keymap('t', '<C-w>', '<C-\\><C-n><C-w>', dfl_opt)
vim.api.nvim_set_keymap('t', '<C-PageUp>', '<C-\\><C-n><C-PageUp>', dfl_opt)
vim.api.nvim_set_keymap('t', '<C-PageDown>', '<C-\\><C-n><C-PageDown>', dfl_opt)

-- vim.api.nvim_set_keymap('i', '<C-S-C>', '"+y', dfl_opt)
-- vim.api.nvim_set_keymap('i', '<C-S-V>', '"+p', dfl_opt)

vim.api.nvim_set_keymap("i", "<C-S-C>", '"*y :let @+=@*<CR>', {noremap=true, silent=true})
vim.api.nvim_set_keymap("i", "<C-S-V>", '"+p', {noremap=true, silent=true})

-- Leap the whole window
vim.api.nvim_set_keymap("n", "f", ":lua require('leap').leap { target_windows = { vim.fn.win_getid() } }<CR>", {})

vim.opt.clipboard = "unnamedplus"

-- vim.cmd('autocmd TermOpen * setlocal nonumber norelativenumber')

vim.o.belloff = 'all'

vim.opt.foldmethod = "expr"
vim.opt.foldenable = false
vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
