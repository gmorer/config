-- Load the plugins
require("plugins")

if require "first_load"() then
  return
end

-- Load the LSP conf
require("lsp")

-- Load status line
require("statusline")

-- Load telescope
require("telescoop")

-- load Tree conf
require("config.tree")

-- load the indent conf
require("config.indent")

-- load the bindings
require("config.bindings")

-- load Theme
require("config.theme")
