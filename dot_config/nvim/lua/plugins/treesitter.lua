-- Customize Treesitter parsers
-- Note: javascript / typescript / tsx / jsdoc parsers are added by pack.typescript

---@type LazySpec
return {
  "nvim-treesitter/nvim-treesitter",
  opts = {
    ensure_installed = {
      "lua",
      "vim",
      "vimdoc",
      -- Web
      "html",
      "css",
      "scss",
      -- Data / Config
      "json",
      "jsonc",
      "yaml",
      "toml",
      -- Docs
      "markdown",
      "markdown_inline",
      -- Shell
      "bash",
      "regex",
    },
  },
}
