local options = {
  formatters_by_ft = {
    lua = { "stylua" },
    javascript = { "prettier_d" },
    typescript = { "prettier_d" },
    javascriptreact = { "prettier_d" },
    typescriptreact = { "prettier_d" },
    css = { "prettier_d" },
    html = { "prettier_d" },
    json = { "prettier_d" },
    yaml = { "prettier_d" },
    markdown = { "prettier_d" },
  },

  format_on_save = {
    timeout_ms = 500,
    lsp_fallback = true,
  },
}

return options
