require('nvim-treesitter.configs').setup({
  ensure_installed = {
    "lua",
    "vim",
    "markdown",
    "markdown_inline",
    "regex",
  },
  highlight = {
    enable = true,
    use_languagetree = true,
  },
  indent = {
    enable = true,
  }
})
