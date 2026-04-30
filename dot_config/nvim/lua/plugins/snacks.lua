-- Customize Snacks picker behaviour

---@type LazySpec
return {
  "folke/snacks.nvim",
  opts = {
    picker = {
      formatters = {
        file = {
          filename_first = true, -- show filename before directory path
        },
      },
    },
  },
}
