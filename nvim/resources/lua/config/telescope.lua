local map = require('config.utils').map

local silent = {silent = true}
-- Navigate buffers and repos
map('n', '<c-p>', [[<cmd>Telescope find_files<cr>]], silent)
map('n', '<c-o>', [[<cmd>Telescope live_grep<cr>]], silent)

-- require("telescope").load_extension("noice")

return {
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
