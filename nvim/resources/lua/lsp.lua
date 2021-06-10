local lspconfig = require('lspconfig')
local trouble = require('trouble')
local lsp_status = require('lsp-status')
local saga = require('lspsaga')
local lspkind = require('lspkind')
local completion = require('completion')
local lsp = vim.lsp
local buf_keymap = vim.api.nvim_buf_set_keymap
local cmd = vim.cmd

 -- completion menu
vim.o.completeopt="menuone,noinsert,noselect"
vim.api.nvim_set_keymap('i', '<Tab>', 'pumvisible() ? "\\<C-n>" : "\\<Tab>"', {expr = true})
vim.api.nvim_set_keymap('i', '<S-Tab>', 'pumvisible() ? "\\<C-p>" : "\\<Tab>"', {expr = true})

local sign_define = vim.fn.sign_define
sign_define('LspDiagnosticsSignError', {text = '', numhl = 'RedSign'})
sign_define('LspDiagnosticsSignWarning', {text = '', numhl = 'YellowSign'})
sign_define('LspDiagnosticsSignInformation', {text = '', numhl = 'WhiteSign'})
sign_define('LspDiagnosticsSignHint', {text = '', numhl = 'BlueSign'})

lspkind.init {symbol_map = kind_symbols}
trouble.setup()

lsp.handlers['textDocument/publishDiagnostics'] = lsp.with(lsp.diagnostic.on_publish_diagnostics, {
  virtual_text = true,
  signs = true,
  update_in_insert = false,
  underline = true
})
saga.init_lsp_saga {use_saga_diagnostic_sign = false}

local keymap_opts = {noremap = true, silent = true}
local function on_attach(client)
  lsp_status.on_attach(client)
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
  rust_analyzer = {},
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
