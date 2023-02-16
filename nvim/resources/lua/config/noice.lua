return {
  lsp = {
    override = {
      ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
      ["vim.lsp.util.stylize_markdown"] = true,
      ["cmp.entry.get_documentation"] = true,
    },
  },
  messages = {
    view_history = "popup",
  },
  views = {
    mini = {
      align = "message-left",
      backend = "mini",
      border = {
        style = "none"
      },
      position = {
        col = "0",
        row = -1
      },
      size = "auto",
      timeout = 2000,
      win_options = {
        winblend = 30,
        winhighlight = {
          IncSearch = "",
          Normal = "NoiceMini",
          Search = ""
        }
      },
      zindex = 60
    },
    cmdline_popup = {
      position = {
        row = "5",
        col = "50%",
      },
      size = {
        width = 60,
        height = "auto",
      },
    },
    popupmenu = {
      relative = "editor",
      position = {
        row = 8,
        col = "50%",
      },
      size = {
        width = 60,
        height = 10,
      },
      border = {
        style = "rounded",
        padding = { 0, 1 },
      },
      win_options = {
        winhighlight = { Normal = "Normal", FloatBorder = "DiagnosticInfo" },
      },
    },
  },
}
