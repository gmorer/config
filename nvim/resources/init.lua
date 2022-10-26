-- Load the plugins
require("plugins")

if require "first_load"() then
  return
end

if vim.g.neovide then
  require("config.neovide")
end

-- Load the LSP conf
require("lsp")

-- load Tree conf
-- require("config.tree")

-- Load status line
require("statusline")

-- load the indent conf
require("config.indent")

-- load the bindings
require("config.bindings")

-- load Theme
require("config.theme")
