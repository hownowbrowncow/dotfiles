-- Disable aerial.nvim due to treesitter API incompatibility
-- Re-enable after aerial updates to support the current Neovim treesitter API
---@type LazySpec
return {
  "stevearc/aerial.nvim",
  enabled = false,
}
