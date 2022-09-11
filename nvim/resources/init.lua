-- Load the plugins
require("plugins")

if require "first_load"() then
  return
end

-- Load the LSP conf
require("lsp")

-- load Tree conf
-- require("config.tree")

-- Load status line
require("statusline")

-- Load telescope
require("telescoop")

-- load the indent conf
require("config.indent")

-- load the bindings
require("config.bindings")

-- load Theme
require("config.theme")
