local map = require('config.utils').map

local silent = {silent = true}
-- Navigate buffers and repos
map('n', '<c-p>', [[<cmd>Telescope find_files<cr>]], silent)
map('n', '<c-o>', [[<cmd>Telescope live_grep<cr>]], silent)
