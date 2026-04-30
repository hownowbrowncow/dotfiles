-- Customize None-ls sources
-- Docs: https://github.com/nvimtools/none-ls.nvim/tree/main/lua/null-ls/builtins

---@type LazySpec
return {
  "nvimtools/none-ls.nvim",
  opts = function(_, opts)
    local null_ls = require "null-ls"

    opts.sources = require("astrocore").list_insert_unique(opts.sources, {
      -- ── Formatting ──────────────────────────────────────────────────────
      -- prettierd: daemon version of Prettier (much faster on repeated saves)
      null_ls.builtins.formatting.prettierd.with {
        filetypes = {
          "javascript",
          "javascriptreact",
          "typescript",
          "typescriptreact",
          "css",
          "scss",
          "less",
          "html",
          "json",
          "jsonc",
          "yaml",
          "markdown",
          "mdx",
        },
      },

      -- ── Diagnostics ─────────────────────────────────────────────────────
      -- ESLint diagnostics handled by the eslint LSP (vscode-eslint-language-server)

      -- stylelint: CSS / SCSS / Less linter
      null_ls.builtins.diagnostics.stylelint.with {
        filetypes = { "css", "scss", "less", "sass" },
      },

      -- ── Code Actions ────────────────────────────────────────────────────
      -- ESLint code actions handled by the eslint LSP (vscode-eslint-language-server)
    })
  end,
}
