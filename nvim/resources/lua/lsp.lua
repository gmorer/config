local lspconfig = require('lspconfig')
local lsp_status = require('lsp-status')
-- local lsp_signature = require('lsp_signature')
-- local completion = require('completion')
local lsp = vim.lsp

require("neodev").setup({})

-- require("vim.lsp.log").set_level "debug"
-- Status part
lsp_status.config(require("config.lspstatus"))

-- completion menu
vim.o.completeopt="menuone,noinsert,noselect"
vim.api.nvim_set_keymap('i', '<Tab>', 'pumvisible() ? "\\<C-n>" : "\\<Tab>"', {expr = true})
vim.api.nvim_set_keymap('i', '<S-Tab>', 'pumvisible() ? "\\<C-p>" : "\\<Tab>"', {expr = true})

local sign_define = vim.fn.sign_define
sign_define('LspDiagnosticsSignError', {text = '', numhl = 'RedSign'})
sign_define('LspDiagnosticsSignWarning', {text = '', numhl = 'YellowSign'})
sign_define('LspDiagnosticsSignInformation', {text = '', numhl = 'WhiteSign'})
sign_define('LspDiagnosticsSignHint', {text = '', numhl = 'BlueSign'})

local nvim_exec = function(txt)
    vim.api.nvim_exec(txt, false)
end

local function on_attach(client, bufnr)

    local function buf_keymap(...)
      vim.api.nvim_buf_set_keymap(bufnr, ...)
    end
    local opts = {noremap = true, silent = true}

    local filetype = vim.api.nvim_buf_get_option(0, "filetype")

    lsp_status.on_attach(client)

    vim.cmd [[augroup gm_lsp_status]]
    vim.cmd [[  autocmd CursorHold,BufEnter <buffer> lua require('lsp-status').update_current_function()]]
    vim.cmd [[augroup END]]
  --   completion.on_attach(client)

    buf_keymap('n', 'gh', '<cmd>lua vim.lsp.buf.lsp_finder()<CR>', opts)
    buf_keymap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
    buf_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
    buf_keymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
    buf_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
    buf_keymap('n', 'gS', '<cmd>lua vim.lsp.buf.signature_help()<CR>',opts)
    buf_keymap('n', 'gTD', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
    buf_keymap('n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
    buf_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
    buf_keymap('n', 'gA', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
    buf_keymap('v', 'gA', ':<C-U>lua vim.lsp.buf.range_code_action()<CR>', opts)
    buf_keymap('n', ']e', '<cmd>lua vim.lsp.diagnostic.goto_next()<cr>', opts)
    buf_keymap('n', '[e', '<cmd>lua vim.lsp.diagnostic.goto_prev<cr>', opts)
    --[[
    nnoremap { "<space>dn", vim.lsp.diagnostic.goto_next, buffer = 0 }
    nnoremap { "<space>dp", vim.lsp.diagnostic.goto_prev, buffer = 0 }
    nnoremap { "<space>sl", vim.lsp.diagnostic.show_line_diagnostics, buffer = 0 }

    nnoremap { "gd", vim.lsp.buf.definition, buffer = 0 }
    nnoremap { "gD", vim.lsp.buf.declaration, buffer = 0 }

    mapper("n", "K", "vim.lsp.buf.hover()")
    mapper("i", "<c-s>", "vim.lsp.buf.signature_help()")
    --]]

    -- Rust is currently the only thing w/ inlay hints
    -- if filetype == "rust" then
    --  vim.cmd(
    --    [[autocmd BufEnter,BufWritePost <buffer> :lua require('lsp_extensions.inlay_hints').request { ]]
    --      .. [[aligned = true, prefix = " » " ]]
    --      .. [[} ]]
    --  )
    -- end
    if vim.tbl_contains({ "go", "rust" }, filetype) then
        vim.cmd [[autocmd BufWritePre <buffer> :lua vim.lsp.buf.format({ async = false })]]
    end
    if vim.tbl_contains({ "deno"}, filetype) then
		vim.g.markdown_fenced_languages = {"ts=typescript"}
	end

    vim.bo.omnifunc = "v:lua.vim.lsp.omnifunc"

    -- Set autocommands conditional on server_capabilities
    if client.server_capabilities.document_highlight then
        nvim_exec [[
        augroup lsp_document_highlight
        autocmd! * <buffer>
        autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
        autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
        augroup END
        ]]
    end
end

local capabilities = lsp_status.capabilities
capabilities.textDocument.completion.completionItem.documentationFormat = { "markdown", "plaintext" }
capabilities.textDocument.completion.completionItem.snippetSupport = true
capabilities.textDocument.completion.completionItem.preselectSupport = true
capabilities.textDocument.completion.completionItem.insertReplaceSupport = true
capabilities.textDocument.completion.completionItem.labelDetailsSupport = true
capabilities.textDocument.completion.completionItem.deprecatedSupport = true
capabilities.textDocument.completion.completionItem.commitCharactersSupport = true
capabilities.textDocument.completion.completionItem.tagSupport = { valueSet = { 1 } }
capabilities.textDocument.completion.completionItem.resolveSupport = {
   properties = {
      "documentation",
      "detail",
      "additionalTextEdits",
   },
}

-- replace the default lsp diagnostic symbols
local function lspSymbol(name, icon)
   vim.fn.sign_define("LspDiagnosticsSign" .. name, { text = icon, numhl = "LspDiagnosticsDefault" .. name })
end

lspSymbol("Error", "")
lspSymbol("Information", "")
lspSymbol("Hint", "")
lspSymbol("Warning", "")

vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
   border = "single",
})

-- suppress error messages from lang servers
vim.notify = function(msg, log_level, _opts)
   if msg:match "exit code" then
      return
   end
   if log_level == vim.log.levels.ERROR then
      vim.api.nvim_err_writeln(msg)
   else
      vim.api.nvim_echo({ { msg } }, true, {})
   end
end


local servers = {
    omnisharp = { cmd = { '/home/guilhem/sources/omnisharp-linux-x64/run', '--languageserver' , '--hostPID', tostring(vim.fn.getpid()) } },
    -- bashls = {},
    clangd = {
        cmd = {
            'clangd', -- '--background-index',
            '--clang-tidy', '--completion-style=bundled', '--header-insertion=iwyu',
            '--suggest-missing-includes', '--cross-file-rename'
        },
        handlers = lsp_status.extensions.clangd.setup(),
        init_options = {
            clangdFileStatus = true,
            usePlaceholders = true,
            completeUnimported = true,
            semanticHighlighting = true
        }
    },
    --[[
    cssls = {
        cmd = {'vscode-css-languageserver', '--stdio'},
        filetypes = {"css", "scss", "less", "sass"},
        root_dir = lspconfig.util.root_pattern("package.json", ".git")
    },
    --]]
    ghcide = {},
    html = { cmd = {'vscode-html-languageserver', '--stdio'}},
    jsonls = {cmd = {'json-languageserver', '--stdio'}},
    julials = {settings = {julia = {format = {indent = 2}}}},
    ocamllsp = {},
    gopls = {},
    pyright = {settings = {python = {formatting = {provider = 'yapf'}}}},
    lua_ls =  {
      settings = {
        Lua = {
          runtime = {
            -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
            version = 'LuaJIT',
          },
          diagnostics = {
            -- Get the language server to recognize the `vim` global
            globals = {'vim'},
          },
          workspace = {
            -- Make the server aware of Neovim runtime files
            library = vim.api.nvim_get_runtime_file("", true),
          },
          -- Do not send telemetry data containing a randomized but unique identifier
          telemetry = {
            enable = false,
          },
        },
      },
    },
    texlab = {
        settings = {
            texlab = {
                chktex = {onOpenAndSave = true},
                formatterLineLength = 100,
                forwardSearch = {executable = 'okular', args = {'--unique', 'file:%p#src:%l%f'}}
            }
        },
        commands = {
            TexlabForwardSearch = {
                function()
                    local pos = vim.api.nvim_win_get_cursor(0)
                    local params = {
                        textDocument = {uri = vim.uri_from_bufnr(0)},
                        position = {line = pos[1] - 1, character = pos[2]}
                    }
                    lsp.buf_request(0, 'textDocument/forwardSearch', params,
                    function(err, _, _, _) if err then error(tostring(err)) end end)
                end,
                description = 'Run synctex forward search'
            }
        }
    },
    tsserver = {
		-- Omitting some options
		root_dir = lspconfig.util.root_pattern("package.json")
	},
    -- denols = {
		-- Omitting some options
		-- root_dir = lspconfig.util.root_pattern("deno.json"),
		-- init_options = {
		--     		enable = false,
		--     		lint = false,
		--     		unstable = true
		--     	}
	-- },
    vimls = {}
}

lspconfig.rust_analyzer.setup {
    cmd = { "rust-analyzer", "" },
    filetypes = { "rust" },
    on_attach = on_attach,
    settings = {
        ["rust-analyzer"] = {
            experimental = {
                procAttrMacros = true
            },
            cargo = {
                loadOutDirsFromCheck = true,
            },
            procMacro = {
                enable = true,
            },
            -- diagnostics = {
                -- disabled = {"missing-unsafe"},
            -- },
        }
    },
    on_init = function(client)
        client.config.flags = client.config.flags or {}
        client.config.flags.allow_incremental_sync = true
        -- client.config.diagnostics.disabled = '["missing-unsafe"]'
    end,
}

local snippet_capabilities = {
    textDocument = {completion = {completionItem = {snippetSupport = true}}}
}

for server, config in pairs(servers) do
    if type(config) == 'function' then config = config() end
    config.on_attach = on_attach
    config.flags = { debounce_text_changes = 500 }
    config.capabilities = capabilities
    lspconfig[server].setup(config)
end
