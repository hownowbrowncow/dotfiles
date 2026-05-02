-- AstroCore provides a central place to modify mappings, vim options, autocommands, and more!
-- Configuration documentation can be found with `:h astrocore`

---@type LazySpec
return {
  "AstroNvim/astrocore",
  ---@type AstroCoreOpts
  opts = {
    -- Configure core features of AstroNvim
    features = {
      large_buf = { size = 1024 * 256, lines = 10000 }, -- limits for disabling features on large files
      autopairs = true,         -- enable autopairs at start
      cmp = true,               -- enable completion at start
      diagnostics = { virtual_text = true, virtual_lines = false },
      highlighturl = true,      -- highlight URLs at start
      notifications = true,     -- enable notifications at start
    },
    -- Diagnostics configuration (vim.diagnostic.config)
    diagnostics = {
      virtual_text = true,
      underline = true,
    },
    -- vim options
    options = {
      opt = {
        relativenumber = true,
        number = true,
        spell = false,
        signcolumn = "yes",
        wrap = false,
        scrolloff = 8,     -- keep 8 lines visible above/below cursor
        sidescrolloff = 8,
        cursorline = true,   -- highlight the current line
        cursorcolumn = true, -- highlight the current column
        guicursor = "n-v-c-sm:block,i-ci-ve:ver25,r-cr-o:hor20", -- beam cursor in insert mode
      },
      g = {},
    },
    -- Cursor crosshair: let the colorscheme handle CursorLine/CursorColumn colors
    -- kanagawa-wave has good defaults; CursorLineNr bolded for visibility
    autocmds = {
      cursor_highlights = {
        {
          event = "ColorScheme",
          desc = "Bold cursor line number",
          callback = function()
            local hl = vim.api.nvim_get_hl(0, { name = "CursorLineNr" })
            hl.bold = true
            vim.api.nvim_set_hl(0, "CursorLineNr", hl)
          end,
        },
      },
    },
    -- Mappings (leaders are set in lazy_setup.lua)
    mappings = {
      n = {
        -- Buffer navigation
        ["]b"] = { function() require("astrocore.buffer").nav(vim.v.count1) end, desc = "Next buffer" },
        ["[b"] = { function() require("astrocore.buffer").nav(-vim.v.count1) end, desc = "Previous buffer" },

        -- Close a buffer chosen from the tabline
        ["<Leader>bd"] = {
          function()
            require("astroui.status.heirline").buffer_picker(
              function(bufnr) require("astrocore.buffer").close(bufnr) end
            )
          end,
          desc = "Close buffer from tabline",
        },

        -- Snacks UX toggles
        ["<Leader>uS"] = { function() require("snacks").toggle.scroll():toggle() end, desc = "Toggle smooth scroll" },
        ["<Leader>ud"] = { function() require("snacks").toggle.dim():toggle() end, desc = "Toggle dim mode" },
        ["<Leader>uw"] = { function() require("snacks").toggle.words():toggle() end, desc = "Toggle word references" },

        -- Snacks scratch buffers
        ["<Leader>."] = { function() require("snacks").scratch() end, desc = "Toggle scratch buffer" },
        ["<Leader>f."] = { function() require("snacks").scratch.select() end, desc = "Select scratch buffer" },

        -- Snacks LSP-aware file rename
        ["<Leader>cR"] = { function() require("snacks").rename.rename_file() end, desc = "Rename file (LSP)" },
      },
    },
  },
}
