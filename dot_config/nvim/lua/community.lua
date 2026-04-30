-- AstroCommunity: import any community modules here
-- We import this file in `lazy_setup.lua` before the `plugins/` folder.
-- This guarantees that the specs are processed before any user plugins.

---@type LazySpec
return {
  "AstroNvim/astrocommunity",

  -- ── Language Packs ────────────────────────────────────────────────────
  -- TypeScript + React: vtsls LSP, TSX treesitter, neotest-jest, package-info
  { import = "astrocommunity.pack.typescript" },

  -- ── Testing ───────────────────────────────────────────────────────────
  -- Neotest framework with <Leader>T keybindings
  { import = "astrocommunity.test.neotest" },

  -- ── Color & Themes ────────────────────────────────────────────────────
  -- Inline color previews for CSS hex/rgb/hsl values
  { import = "astrocommunity.color.nvim-highlight-colors" },
  -- Colorschemes available to the picker
  { import = "astrocommunity.colorscheme.tokyonight-nvim" },
  { import = "astrocommunity.colorscheme.catppuccin" },
  { import = "astrocommunity.colorscheme.rose-pine" },
  { import = "astrocommunity.colorscheme.kanagawa-nvim" },
  { import = "astrocommunity.colorscheme.nightfox-nvim" },

  -- ── Editing Support ───────────────────────────────────────────────────
  -- Highlights TODO / FIXME / NOTE / HACK / BUG / PERF comments
  { import = "astrocommunity.editing-support.todo-comments-nvim" },

  -- ── Git ───────────────────────────────────────────────────────────────
  -- Full-featured Git UI (`:Neogit`)
  { import = "astrocommunity.git.neogit" },
  -- Side-by-side diff and merge-conflict UI (`:DiffviewOpen`)
  { import = "astrocommunity.git.diffview-nvim" },

  -- ── Motion ────────────────────────────────────────────────────────────
  -- Flash.nvim: fast cursor jumps via `s` / `S` / `r` (remote flash)
  { import = "astrocommunity.motion.flash-nvim" },
}
