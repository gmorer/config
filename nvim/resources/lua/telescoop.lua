local map = require('config.utils').map

local silent = {silent = true}
-- Navigate buffers and repos
map('n', '<c-p>', [[<cmd>Telescope find_files<cr>]], silent)
map('n', '<c-o>', [[<cmd>Telescope live_grep<cr>]], silent)

local has_telescope, telescope = pcall(require, "telescope")
if has_telescope then
  telescope.load_extension('frecency')
end
