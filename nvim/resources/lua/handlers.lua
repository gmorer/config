vim.lsp.handlers["textDocument/definition"] = function(_, _, result)
  if not result or vim.tbl_isempty(result) then
    print "[LSP] Could not find definition"
    return
  end

  if vim.tbl_islist(result) then
    vim.lsp.util.jump_to_location(result[1])
  else
    vim.lsp.util.jump_to_location(result)
  end
end

-- vim.lsp.handlers["textDocument/definition"] = vim.lsp.with(
--   vim.lsp.handlers.location, {
--     location_callback = function(location)
--       vim.cmd [[vsplit]]
--       vim.lsp.util.jump_to_location(location)
--     end
--   }
-- )

-- Normal configuration, but for now testing out workspace configuration.
-- vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
--   vim.lsp.diagnostic.on_publish_diagnostics, {
--     signs = {
--       severity_limit = "Error",
--     },
--     -- virtual_text = {
--     --   severity_limit = "Warning",
--     -- },
--   }
-- )
vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
  require("lsp_extensions.workspace.diagnostic").handler,
  {
    signs = {
      severity_limit = "Error",
    },
    underline = {
      severity_limit = "Warning",
    },
    virtual_text = true,
  }
)

vim.lsp.handlers["textDocument/hover"] = require("lspsaga.hover").handler

function DoSomeLens()
  print "Lens Requesting..."

  vim.lsp.buf_request(0, "textDocument/codeLens", {
    textDocument = vim.lsp.util.make_text_document_params(),
  })

  print "... Done"
end

vim.lsp.handlers["textDocument/codeLens"] = function(err, _, result)
  print "Code Lens..."
  P(result)
  print "...Code Lens"
end

-- Override various utility functions.
-- vim.lsp.diagnostic.show_line_diagnostics = require('lspsaga.diagnostic').show_line_diagnostics

-- TODO: Move to colorbuddy
vim.cmd [[highlight LspLinesDiagBorder guifg=white]]
vim.cmd [[highlight LineDiagTuncateLine guifg=white]]

local ns_rename = vim.api.nvim_create_namespace "tj_rename"

local saga_config = require("lspsaga").config_values
saga_config.rename_prompt_prefix = ">"
