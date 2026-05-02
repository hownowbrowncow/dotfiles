-- AstroLSP allows you to customize the features in AstroNvim's LSP configuration engine
-- Configuration documentation can be found with `:h astrolsp`

---@type LazySpec
return {
  "AstroNvim/astrolsp",
  ---@type AstroLSPOpts
  opts = {
    -- Configuration table of features provided by AstroLSP
    features = {
      codelens = true,        -- enable/disable codelens refresh on start
      inlay_hints = false,    -- enable/disable inlay hints on start (toggle: <Leader>uH)
      semantic_tokens = true, -- enable/disable semantic token highlighting
      signature_help = true,  -- auto-show function parameter hints while typing
    },
    -- Customize lsp formatting options
    formatting = {
      format_on_save = {
        enabled = true, -- format on save globally
      },
      -- Disable LSP-based formatting for servers where we use prettier instead.
      -- jsonls expands short arrays to multi-line; prettier handles JSON formatting correctly.
      disabled = { "vtsls", "jsonls" },
      timeout_ms = 2000,
    },
    -- Enable servers already installed outside of Mason
    servers = {},
    -- Customize language server configuration options passed to `lspconfig`
    ---@diagnostic disable: missing-fields
    config = {},
    -- Customize how language servers are attached
    handlers = {},
    -- Configure buffer local auto commands to add when attaching a language server
    -- ESLint fix-on-save handled by eslint_d formatting source in none-ls
    autocmds = {
      lsp_codelens_refresh = {
        cond = "textDocument/codeLens",
        {
          event = { "InsertLeave", "BufEnter" },
          desc = "Refresh codelens (buffer)",
          callback = function(args)
            if require("astrolsp").config.features.codelens then vim.lsp.codelens.refresh { bufnr = args.buf } end
          end,
        },
      },
    },
    -- Mappings set up when a language server attaches
    mappings = {
      n = {
        gD = {
          function() vim.lsp.buf.declaration() end,
          desc = "Declaration of current symbol",
          cond = "textDocument/declaration",
        },
        ["<Leader>uY"] = {
          function() require("astrolsp.toggles").buffer_semantic_tokens() end,
          desc = "Toggle LSP semantic highlight (buffer)",
          cond = function(client)
            return client.supports_method "textDocument/semanticTokens/full" and vim.lsp.semantic_tokens ~= nil
          end,
        },
      },
    },
    -- Custom `on_attach` run after the default AstroNvim `on_attach`
    on_attach = function(client, bufnr) end,
  },
}
