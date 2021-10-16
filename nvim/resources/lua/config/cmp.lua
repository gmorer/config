local cmp = require "cmp"

vim.opt.completeopt = "menuone,noselect"

cmp.setup({
    snippet = {
       expand = function(args)
          require("luasnip").lsp_expand(args.body)
       end,
    },
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
	mapping = {
		-- Waiting for fix
		-- ['<Tab>'] = cmp.mapping.select_next_item(),
		-- ['<S-Tab>'] = cmp.mapping.select_prev_item()
		['<Up>'] = cmp.mapping.select_next_item(),
		['<Down>'] = cmp.mapping.select_prev_item()
	},
    sources = {
       { name = "nvim_lsp" },
       { name = "buffer" },
       { name = "nvim_lua" },
    },
})
