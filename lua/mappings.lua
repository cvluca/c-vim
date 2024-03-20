require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })

map("i", "jk", "<ESC>", { desc = "Escape insert mode" })

-- nvchad

map("n", "<C-x>", function()
  require("nvchad.tabufline").close_buffer()
end, { desc = "Buffer Close" })

-- conform

map("n", "<leader>fm", function()
  require("conform").format()
end, { desc = "File Format with conform" })

-- nvim-tree 

map("n", "<leader>tt", function()
  require("nvim-tree.api").tree.toggle({ path = "<args>", find_file = false, update_root = false, focus = true, })
end, { desc = "Nvimtree Toggle window" })

-- Telescope

map("n", "<leader>G", function()
  require("telescope.builtin").grep_string()
end, { desc = "Telescope Grep String under current cursor" })

map("n", "<leader>fc", function()
  require("telescope.builtin").find_files({ cwd = vim.fn.expand('%:p:h') })
end, { desc = "Telescope Find in current directory" })
