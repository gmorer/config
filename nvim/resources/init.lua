-- Initiat the plugin manager --
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- load the bindings
require("config.bindings")

require("lazy").setup("plugins")

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

-- load Theme
require("config.theme")

-- Hexedit
require("binedit")
