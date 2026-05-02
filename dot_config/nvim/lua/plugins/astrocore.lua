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
    -- Make cursor crosshair more visible
    autocmds = {
      cursor_highlights = {
        {
          event = "ColorScheme",
          desc = "Set cursor crosshair highlights",
          callback = function()
            vim.api.nvim_set_hl(0, "CursorLine", { bg = "#2a2a3a" })
            vim.api.nvim_set_hl(0, "CursorColumn", { bg = "#2a2a3a" })
            vim.api.nvim_set_hl(0, "CursorLineNr", { fg = "#e0af68", bold = true })
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
      },
    },
  },
}
