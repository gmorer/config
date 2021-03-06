local lspconfig = require('lspconfig')
local lsp_status = require('lsp-status')
local saga = require('lspsaga')
local completion = require('completion')
local lsp = vim.lsp
local buf_keymap = vim.api.nvim_buf_set_keymap
local cmd = vim.cmd

_ = require("lspkind").init()
require("vim.lsp.log").set_level "debug"
require "handlers"

-- Status part
lsp_status.config(require("config.lspstatus"))

lsp_status.register_progress()

 -- completion menu
vim.o.completeopt="menuone,noinsert,noselect"
vim.api.nvim_set_keymap('i', '<Tab>', 'pumvisible() ? "\\<C-n>" : "\\<Tab>"', {expr = true})
vim.api.nvim_set_keymap('i', '<S-Tab>', 'pumvisible() ? "\\<C-p>" : "\\<Tab>"', {expr = true})

local sign_define = vim.fn.sign_define
sign_define('LspDiagnosticsSignError', {text = '', numhl = 'RedSign'})
sign_define('LspDiagnosticsSignWarning', {text = '', numhl = 'YellowSign'})
sign_define('LspDiagnosticsSignInformation', {text = '', numhl = 'WhiteSign'})
sign_define('LspDiagnosticsSignHint', {text = '', numhl = 'BlueSign'})

saga.init_lsp_saga {use_saga_diagnostic_sign = false}

local nvim_exec = function(txt)
  vim.api.nvim_exec(txt, false)
end

local keymap_opts = {noremap = true, silent = true}
local function on_attach(client)

  local filetype = vim.api.nvim_buf_get_option(0, "filetype")

  lsp_status.on_attach(client)
  vim.cmd [[augroup gm_lsp_status]]
  vim.cmd [[  autocmd CursorHold,BufEnter <buffer> lua require('lsp-status').update_current_function()]]
  vim.cmd [[augroup END]]
  completion.on_attach(client)

  buf_keymap(0, 'n', 'gh', '<cmd>lua require("lspsaga.provider").lsp_finder()<CR>', keymap_opts)
  buf_keymap(0, 'n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', keymap_opts)
  buf_keymap(0, 'n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', keymap_opts)
  buf_keymap(0, 'n', 'K', '<cmd>lua require("lspsaga.hover").render_hover_doc()<CR>', keymap_opts)
  buf_keymap(0, 'n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', keymap_opts)
  buf_keymap(0, 'n', 'gS', '<cmd>lua require("lspsaga.signaturehelp").signature_help()<CR>',
             keymap_opts)
  buf_keymap(0, 'n', 'gTD', '<cmd>lua vim.lsp.buf.type_definition()<CR>', keymap_opts)
  buf_keymap(0, 'n', '<leader>rn', '<cmd>lua require("lspsaga.rename").rename()<CR>', keymap_opts)
  buf_keymap(0, 'n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', keymap_opts)
  buf_keymap(0, 'n', 'gA', '<cmd>lua require("lspsaga.codeaction").code_action()<CR>', keymap_opts)
  buf_keymap(0, 'v', 'gA', ':<C-U>lua require("lspsaga.codeaction").range_code_action()<CR>',
             keymap_opts)
  buf_keymap(0, 'n', ']e', '<cmd>lua require("lspsaga.diagnostic").lsp_jump_diagnostic_next()<cr>',
             keymap_opts)
  buf_keymap(0, 'n', '[e', '<cmd>lua require("lspsaga.diagnostic").lsp_jump_diagnostic_prev()<cr>',
             keymap_opts)
  --[[
  nnoremap { "<space>dn", vim.lsp.diagnostic.goto_next, buffer = 0 }
  nnoremap { "<space>dp", vim.lsp.diagnostic.goto_prev, buffer = 0 }
  nnoremap { "<space>sl", vim.lsp.diagnostic.show_line_diagnostics, buffer = 0 }

  nnoremap { "gd", vim.lsp.buf.definition, buffer = 0 }
  nnoremap { "gD", vim.lsp.buf.declaration, buffer = 0 }

  mapper("n", "K", "vim.lsp.buf.hover()")
  mapper("i", "<c-s>", "vim.lsp.buf.signature_help()")
  --]]

  if client.resolved_capabilities.document_formatting then
    buf_keymap(0, 'n', '<leader>lf', '<cmd>lua vim.lsp.buf.formatting()<cr>', keymap_opts)
  end

  if client.resolved_capabilities.document_highlight == true then
    cmd('augroup lsp_aucmds')
    cmd('au CursorHold <buffer> lua vim.lsp.buf.document_highlight()')
    cmd('au CursorHold <buffer> lua require("lspsaga.diagnostic").show_cursor_diagnostics()')
    cmd('au CursorMoved <buffer> lua vim.lsp.buf.clear_references()')
    cmd('augroup END')
  end

  -- Rust is currently the only thing w/ inlay hints
  -- if filetype == "rust" then
  --  vim.cmd(
  --    [[autocmd BufEnter,BufWritePost <buffer> :lua require('lsp_extensions.inlay_hints').request { ]]
  --      .. [[aligned = true, prefix = " » " ]]
  --      .. [[} ]]
  --  )
  -- end
  if vim.tbl_contains({ "go", "rust" }, filetype) then
    vim.cmd [[autocmd BufWritePre <buffer> :lua vim.lsp.buf.formatting_sync()]]
  end

  vim.bo.omnifunc = "v:lua.vim.lsp.omnifunc"

  -- Set autocommands conditional on server_capabilities
  if client.resolved_capabilities.document_highlight then
    nvim_exec [[
      augroup lsp_document_highlight
        autocmd! * <buffer>
        autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
        autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
      augroup END
    ]]
  end
end

local servers = {
  omnisharp = { cmd = { '/home/guilhem/sources/omnisharp-linux-x64/run', '--languageserver' , '--hostPID', tostring(vim.fn.getpid()) } },
  bashls = {},
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
  cssls = {
    filetypes = {"css", "scss", "less", "sass"},
    root_dir = lspconfig.util.root_pattern("package.json", ".git")
  },
  ghcide = {},
  html = {},
  jsonls = {cmd = {'json-languageserver', '--stdio'}},
  julials = {settings = {julia = {format = {indent = 2}}}},
  ocamllsp = {},
  gopls = {},
  pyright = {settings = {python = {formatting = {provider = 'yapf'}}}},
  sumneko_lua = function()
    return require('lua-dev').setup({lspconfig = {cmd = {'lua-language-server'}}})
  end,
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
  tsserver = {},
  vimls = {}
}

lspconfig.rust_analyzer.setup {
  cmd = { "rust-analyzer" },
  filetypes = { "rust" },
  on_attach = on_attach,
  on_init = function(client)
    client.config.flags = client.config.flags or {}
    client.config.flags.allow_incremental_sync = true
  end,
  capabilities = lsp_status.capabilities,
}

local snippet_capabilities = {
  textDocument = {completion = {completionItem = {snippetSupport = true}}}
}

for server, config in pairs(servers) do
  if type(config) == 'function' then config = config() end
  config.on_attach = on_attach
  config.capabilities = vim.tbl_deep_extend('keep', config.capabilities or {},
                                            lsp_status.capabilities, snippet_capabilities)
  lspconfig[server].setup(config)
end
