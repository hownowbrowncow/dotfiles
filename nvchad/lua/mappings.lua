require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set
-- Grep search
map("n", "<leader>fg", "<cmd>Telescope live_grep<cr>", { desc = "Live grep" })
