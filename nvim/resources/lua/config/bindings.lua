local dfl_opt = { noremap = true, silent = true }

-- nnoremap <C-n> :NvimTreeToggle<CR>
vim.api.nvim_set_keymap('', '<C-n>', ':NvimTreeFindFileToggle<CR>', dfl_opt)

-- nnoremap <Leader>s :<C-u> :Git blame<CR>
vim.api.nvim_set_keymap('', '<Leader>s', ':<C-u> : GitMessenger<CR>', dfl_opt)

vim.api.nvim_set_keymap('', '<C-/>', ':CommentToggle<CR>', dfl_opt)

vim.api.nvim_set_var('VM_maps', {['Find Under'] = '<C-d>', ['Find Subword Under'] = '<C-d>'})

vim.api.nvim_set_keymap('t', '<C-`>', '<C-\\><C-n>', { noremap = true, silent = true })
vim.cmd('autocmd TermOpen * setlocal nonumber norelativenumber')


vim.o.belloff = 'all'
