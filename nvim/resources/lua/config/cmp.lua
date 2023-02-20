return {
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
		['<Tab>'] = function(fallback)
			local cmp = require("cmp")
			if cmp.visible() then
				cmp.select_next_item()
			else
				fallback()
			end
		end,
		['<S-Tab>'] = function(fallback)
			local cmp = require("cmp")
			if cmp.visible() then
				cmp.select_prev_item()
			else
				fallback()
			end
		end,
	},
    sources = {
       { name = "nvim_lsp" },
       { name = "buffer" },
       { name = "nvim_lua" },
    },
  preselect = "none" -- cmp.PreselectMode.None
}
