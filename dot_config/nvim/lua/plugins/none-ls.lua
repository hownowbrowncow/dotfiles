-- Customize None-ls sources
-- Docs: https://github.com/nvimtools/none-ls.nvim/tree/main/lua/null-ls/builtins

local js_filetypes = {
  "javascript",
  "javascriptreact",
  "typescript",
  "typescriptreact",
}

---@type LazySpec
return {
  "nvimtools/none-ls.nvim",
  dependencies = {
    "nvimtools/none-ls-extras.nvim",
  },
  opts = function(_, opts)
    local null_ls = require "null-ls"

    opts.sources = require("astrocore").list_insert_unique(opts.sources, {
      -- ── Formatting ──────────────────────────────────────────────────────
      -- eslint_d: fast ESLint auto-fix on save (runs before prettierd)
      -- prefer_local uses the project's eslint when available (monorepo support)
      require("none-ls.formatting.eslint_d").with {
        filetypes = js_filetypes,
        prefer_local = "node_modules/.bin",
      },

      -- prettier: uses project-local prettier to resolve workspace configs (e.g., monorepos)
      -- Falls back to global prettierd when no local prettier is found
      null_ls.builtins.formatting.prettier.with {
        prefer_local = "node_modules/.bin",
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
      -- eslint_d: inline ESLint diagnostics
      require("none-ls.diagnostics.eslint_d").with {
        filetypes = js_filetypes,
        prefer_local = "node_modules/.bin",
      },

      -- stylelint: CSS / SCSS / Less linter
      null_ls.builtins.diagnostics.stylelint.with {
        filetypes = { "css", "scss", "less", "sass" },
      },

      -- ── Code Actions ────────────────────────────────────────────────────
      -- eslint_d: ESLint code actions (quick fixes)
      require("none-ls.code_actions.eslint_d").with {
        filetypes = js_filetypes,
        prefer_local = "node_modules/.bin",
      },
    })
  end,
}
