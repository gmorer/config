local cmp = require "cmp"

vim.opt.completeopt = "menuone,noselect"

cmp.setup({
    formatting = {
      format = function(entry, vim_item)
         -- load lspkind icons
         vim_item.kind = string.format(
            "%s %s",
            require("config.lspkind_icons").icons[vim_item.kind],
            vim_item.kind
         )

         vim_item.menu = ({
            nvim_lsp = "[LSP]",
            nvim_lua = "[Lua]",
            buffer = "[BUF]",
         })[entry.source.name]

         return vim_item
      end,
   },
    sources = {
      { name = "nvim_lsp" },
      { name = "buffer" },
      { name = "nvim_lua" },
   },
})
