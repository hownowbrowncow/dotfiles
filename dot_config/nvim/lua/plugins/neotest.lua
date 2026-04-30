-- Add neotest-vitest adapter alongside the jest adapter from pack.typescript

---@type LazySpec
return {
  "nvim-neotest/neotest",
  dependencies = { "marilari88/neotest-vitest" },
  opts = function(_, opts)
    opts.adapters = opts.adapters or {}
    table.insert(opts.adapters, require "neotest-vitest")
  end,
}
