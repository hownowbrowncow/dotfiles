-- AstroCommunity: import any community modules here
-- We import this file in `lazy_setup.lua` before the `plugins/` folder.
-- This guarantees that the specs are processed before any user plugins.

---@type LazySpec
return {
  "AstroNvim/astrocommunity",

  -- ── Language Packs ────────────────────────────────────────────────────
  -- TypeScript + React: vtsls LSP, TSX treesitter, neotest-jest, package-info
  { import = "astrocommunity.pack.typescript" },
  -- JSON: jsonls with SchemaStore (autocomplete for package.json, tsconfig, etc.)
  { import = "astrocommunity.pack.json" },
  -- Markdown: marksman LSP (link completion, heading navigation)
  { import = "astrocommunity.pack.markdown" },

  -- ── Testing ───────────────────────────────────────────────────────────
  -- Neotest framework with <Leader>T keybindings
  { import = "astrocommunity.test.neotest" },

  -- ── Color & Themes ────────────────────────────────────────────────────
  -- Inline color previews for CSS hex/rgb/hsl values
  { import = "astrocommunity.color.nvim-highlight-colors" },
  -- Rainbow bracket nesting (helpful in deep JSX / TypeScript generics)
  { import = "astrocommunity.editing-support.rainbow-delimiters-nvim" },
  -- Colorschemes available to the picker (<Leader>ft)
  { import = "astrocommunity.colorscheme.tokyonight-nvim" },
  { import = "astrocommunity.colorscheme.catppuccin" },
  { import = "astrocommunity.colorscheme.rose-pine" },
  { import = "astrocommunity.colorscheme.kanagawa-nvim" },
  { import = "astrocommunity.colorscheme.nightfox-nvim" },

  -- ── Editing Support ───────────────────────────────────────────────────
  -- Highlights TODO / FIXME / NOTE / HACK / BUG / PERF comments
  { import = "astrocommunity.editing-support.todo-comments-nvim" },
  -- Treesitter context: pin current function/class header at top of screen
  { import = "astrocommunity.editing-support.nvim-treesitter-context" },
  -- Split/join: toggle single-line ↔ multi-line with <Leader>m
  { import = "astrocommunity.editing-support.treesj" },
  -- Smart increment: <C-a>/<C-x> cycles booleans, dates, semver, etc.
  { import = "astrocommunity.editing-support.dial-nvim" },
  -- Yank ring: cycle paste history with [y / ]y, browse with <Leader>fy
  { import = "astrocommunity.editing-support.yanky-nvim" },
  -- Refactoring: extract function/variable, inline variable (<Leader>r)
  { import = "astrocommunity.editing-support.refactoring-nvim" },
  -- Case conversion: camelCase ↔ snake_case ↔ PascalCase ↔ kebab-case
  { import = "astrocommunity.editing-support.text-case-nvim" },
  -- Generate JSDoc/TSDoc annotation skeletons (<Leader>a)
  { import = "astrocommunity.editing-support.neogen" },

  -- ── Diagnostics ───────────────────────────────────────────────────────
  -- Trouble: pretty diagnostics / TODO / quickfix panel (<Leader>x)
  { import = "astrocommunity.diagnostics.trouble-nvim" },

  -- ── LSP Enhancements ──────────────────────────────────────────────────
  -- Translate cryptic TypeScript errors to plain English
  { import = "astrocommunity.lsp.ts-error-translator-nvim" },
  -- Live rename preview: see all references update as you type
  { import = "astrocommunity.lsp.inc-rename-nvim" },
  -- Code actions with live diff preview before applying
  { import = "astrocommunity.lsp.actions-preview-nvim" },
  -- Auto-update imports when renaming/moving files in neo-tree
  { import = "astrocommunity.lsp.nvim-lsp-file-operations" },

  -- ── Quickfix ────────────────────────────────────────────────────────────
  -- Better quickfix with preview, fzf filtering, multi-select
  { import = "astrocommunity.quickfix.nvim-bqf" },

  -- ── Search ────────────────────────────────────────────────────────────
  -- Project-wide find & replace UI (<Leader>s)
  { import = "astrocommunity.search.grug-far-nvim" },

  -- ── Motion ────────────────────────────────────────────────────────────
  -- Flash.nvim: fast cursor jumps via `s` / `S` / `r` (remote flash)
  { import = "astrocommunity.motion.flash-nvim" },
  -- Surround: add/delete/replace surrounding chars (gza, gzd, gzr)
  { import = "astrocommunity.motion.mini-surround" },
  -- Enhanced text objects: daa (delete arg), cia (change arg), viq (select in quotes)
  { import = "astrocommunity.motion.mini-ai" },
  -- Move lines/selections with Alt+h/j/k/l
  { import = "astrocommunity.motion.mini-move" },

  -- ── Git ───────────────────────────────────────────────────────────────
  -- Full-featured Git UI (`:Neogit`)
  { import = "astrocommunity.git.neogit" },
  -- Side-by-side diff and merge-conflict UI (`:DiffviewOpen`)
  { import = "astrocommunity.git.diffview-nvim" },

  -- ── Markdown ──────────────────────────────────────────────────────────
  -- Rich markdown rendering in-buffer (headings, checkboxes, tables)
  { import = "astrocommunity.markdown-and-latex.render-markdown-nvim" },

  -- ── Comment ─────────────────────────────────────────────────────────
  -- Context-aware comments: uses {/* */} in JSX, // in TS, etc.
  { import = "astrocommunity.comment.ts-comments-nvim" },

  -- ── REST Client ───────────────────────────────────────────────────────
  -- Send HTTP requests from .http files (<Leader>R prefix to avoid refactoring conflict)
  {
    import = "astrocommunity.programming-language-support.kulala-nvim",
  },
  {
    "mistweaverco/kulala.nvim",
    opts = { global_keymaps_prefix = "<leader>R" },
  },

  -- ── Recipes ───────────────────────────────────────────────────────────
  -- Auto-restore last session when opening nvim in a project directory
  { import = "astrocommunity.recipes.auto-session-restore" },
  -- Full diagnostic on current line, short virtual text on others
  { import = "astrocommunity.recipes.diagnostic-virtual-lines-current-line" },
}
