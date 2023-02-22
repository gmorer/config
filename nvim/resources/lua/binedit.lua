-- Utility to edit binaries

local group = vim.api.nvim_create_augroup("Hexedit", {clear = true})

vim.api.nvim_create_user_command("BinEdit", function ()
  vim.bo.bin = true
  vim.cmd("silent :e")
  vim.cmd("silent %!xxd")
  vim.bo.filetype = "xxd"

  local clients = vim.lsp.get_active_clients({bufnr = 0})
  for client_id, _ in pairs(clients) do
    vim.lsp.buf_detach_client(bufnr, client_id)
  end

  vim.api.nvim_create_autocmd("BufWritePost", {
    group = group,
    callback = function ()
      if vim.bo.filetype == "xxd" then
        vim.cmd("silent %!xxd -r")
        vim.cmd("silent w")
        vim.cmd("silent %!xxd")
      end
    end,
  })

end, {})

vim.api.nvim_create_user_command("BinExit", function ()
  vim.bo.bin = false
  vim.cmd("silent :e!")
end, {})
