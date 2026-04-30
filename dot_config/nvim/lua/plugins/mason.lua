-- Customize Mason: automatically install tools on startup

---@type LazySpec
return {
  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    -- overrides `require("mason-tool-installer").setup(...)`
    opts = {
      -- Use the names shown in `:Mason` (not npm package names)
      ensure_installed = {
        -- ── Language Servers ──────────────────────────────────────────────
        "lua-language-server",
        -- vtsls (TypeScript) is installed by pack.typescript

        -- ── Formatters ────────────────────────────────────────────────────
        "stylua",     -- Lua formatter
        "prettierd",  -- Fast Prettier daemon (JS/TS/CSS/HTML/JSON/YAML/MD)

        -- ── Linters ───────────────────────────────────────────────────────
        "eslint-lsp", -- ESLint LSP (supports ESLint 10 + flat config)
        "stylelint",  -- CSS / SCSS / Less linter

        -- ── Debuggers ─────────────────────────────────────────────────────
        "debugpy",

        -- ── Other ─────────────────────────────────────────────────────────
        "tree-sitter-cli",
      },
    },
  },
}
