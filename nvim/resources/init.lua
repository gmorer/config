-- Load the plugins
require("plugins")

if require "first_load"() then
  return
end

-- Load status line
require("statusline").status()

-- Load the LSP conf
require("lsp")

-- Load telescope
require("telescoop")

-- load Tree conf
require("config.tree")

-- load the bindings
require("config.bindings")

-- load Theme
require("config.theme")
