local M = {}

-- require('nvim-treesitter.configs').setup({
M.setup = {
  ensure_installed = {
    "lua",
    "vim",
    "markdown",
    "markdown_inline",
  },
  highlight = {
    enable = true,
    use_languagetree = true,
  },
}

M.config = function()
  -- Use treesitter for folding
  vim.opt.foldmethod = "expr"
  vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
  -- Open everyuthing by default
  vim.opt.foldenable = false
  -- vim.opt.foldlevelstart = 999
end

return M
