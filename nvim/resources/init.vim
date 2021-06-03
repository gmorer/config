" --- Keybindings:
"  |Ctrl-n|         Toggle file explorer
"  |Ctrl-p|         Quick file access
"  |Ctrl-d|         Multi cursor next word
"  |Ctrl-(Up|Down)| Multi cursor up or down
"  |Ctrl-]|         Go to definition
"  |Ctrl-t|         Come back from definition
"  <Leader-s>       git blame the ligne

call plug#begin(stdpath('data') . '/plugged')

" --- MultiCursor ---
Plug 'mg979/vim-visual-multi'
let g:VM_maps = {}
let g:VM_maps['Find Under']         = '<C-d>'
let g:VM_maps['Find Subword Under'] = '<C-d>'

" --- Conf Nerdtree ---
Plug 'kyazdani42/nvim-web-devicons' " for file icons
Plug 'kyazdani42/nvim-tree.lua'     " for file explorer
let g:nvim_tree_quit_on_open = 1
let g:nvim_tree_git_hl = 1
let g:nvim_tree_highlight_opened_files = 1
let g:nvim_tree_auto_open = 1
let g:nvim_tree_indent_markers = 1
nnoremap <C-n> :NvimTreeToggle<CR>
nnoremap <leader>r :NvimTreeRefresh<CR>

" --- Dependencies ---
Plug 'xolox/vim-misc'

" --- Tabs ---
Plug 'vim-airline/vim-airline'
let g:airline#extensions#tabline#left_alt_sep = ' | '
let g:airline_powerline_fonts = 1

" --- Git Blame ---
Plug 'zivyangll/git-blame.vim'
nnoremap <Leader>s :<C-u>call gitblame#echo()<CR>

" --- Git diff ---
Plug 'airblade/vim-gitgutter'

" --- Git commands ---
Plug 'tpope/vim-fugitive'

" --- Find file ---
Plug 'ctrlpvim/ctrlp.vim'
let g:ctrlp_custom_ignore = {
    \ 'dir':  '\v(.git|node_modules|target|vendor)$',
    \ 'file': '\v\.(exe|so|dll|a|o)$',
    \ }

" --- Jump ---
Plug 'xolox/vim-easytags'
let g:easytags_opts = ["--options=$HOME/.config/ctags/ctagsrc", '--fields=+l']

" --- completion ---
Plug 'valloric/youcompleteme'
let g:ycm_complete_in_strings = 0
let g:ycm_collect_identifiers_from_tags_files = 1
let g:ycm_seed_identifiers_with_syntax = 1
let g:ycm_add_preview_to_completeopt = 1
let g:ycm_autoclose_preview_window_after_completion = 1
let g:ycm_autoclose_preview_window_after_insertion = 1

" --- Color sheme ---
Plug 'morhetz/gruvbox'
set background=dark

call plug#end()

colorscheme gruvbox
nnoremap U <C-R> " Dunno it was not present anymore
