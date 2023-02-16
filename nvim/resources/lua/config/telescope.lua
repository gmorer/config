local M = {}
M.init = function()
  local map = require('config.utils').map

  local silent = {silent = true}
  -- Navigate buffers and repos
  map('n', '<c-p>', [[<cmd>Telescope find_files<cr>]], silent)
  map('n', '<c-o>', [[<cmd>Telescope live_grep<cr>]], silent)
end

-- require("telescope").load_extension("noice")

M.opts = {
    defaults = {
        layout_strategy = 'flex',
        scroll_strategy = 'cycle',
        file_ignore_patterns = {
            "target/.*",
            ".git/.*",
            "node_modules/.*",
            "vendor/.*",
        },
    }
}

return M
