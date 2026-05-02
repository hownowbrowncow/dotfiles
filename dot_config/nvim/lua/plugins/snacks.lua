-- Customize Snacks features
-- AstroNvim already enables: dashboard, indent, scope, zen, notifier, picker, input

---@type LazySpec
return {
  "folke/snacks.nvim",
  opts = {
    -- ── Picker ────────────────────────────────────────────────────────────
    picker = {
      formatters = {
        file = {
          filename_first = true, -- show filename before directory path
        },
      },
    },

    -- ── Smooth scrolling ──────────────────────────────────────────────────
    scroll = {
      animate = {
        duration = { step = 15, total = 150 },
        easing = "linear",
      },
      filter = function(buf)
        return vim.g.snacks_scroll ~= false
          and vim.b[buf].snacks_scroll ~= false
          and vim.bo[buf].buftype ~= "terminal"
      end,
    },

    -- ── Dim inactive code ─────────────────────────────────────────────────
    dim = {
      scope = {
        min_size = 5,
        max_size = 20,
      },
    },

    -- ── Indent scope animation ────────────────────────────────────────────
    -- Override AstroNvim default (which disables animation)
    indent = {
      animate = {
        enabled = true,
        style = "out",
        easing = "linear",
        duration = {
          step = 20,
          total = 200,
        },
      },
    },

    -- ── Words: highlight references ───────────────────────────────────────
    words = { enabled = true },

    -- ── Lazygit: floating terminal with theme sync ────────────────────────
    lazygit = {
      configure = true, -- auto-sync kanagawa theme to lazygit
    },

    -- ── Big file: disable heavy features on large files ───────────────────
    bigfile = { enabled = true },

    -- ── Quick file: render files before plugins load ──────────────────────
    quickfile = { enabled = true },

    -- ── Scratch: persistent scratch buffers per project ───────────────────
    scratch = {},

    -- ── Rename: LSP-aware file rename ─────────────────────────────────────
    rename = {},

    -- ── Git browse: open files on GitHub ──────────────────────────────────
    gitbrowse = {},
  },
}
