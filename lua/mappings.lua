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

-- lspconfig

-- Use LspAttach autocommand to only map the following keys
-- after the language server attaches to the current buffer
vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('UserLspConfig', {}),
  callback = function(ev)
    -- Enable completion triggered by <c-x><c-o>
    vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

    -- Buffer local mappings.
    -- See `:help vim.lsp.*` for documentation on any of the below functions
    local opts = { buffer = ev.buf }
    map('n', 'gD', vim.lsp.buf.declaration, opts)
    map('n', 'gd', vim.lsp.buf.definition, opts)
    map('n', 'K', vim.lsp.buf.hover, opts)
    map('n', 'gi', vim.lsp.buf.implementation, opts)
    map('n', '<C-k>', vim.lsp.buf.signature_help, opts)
    map('n', '<space>wa', vim.lsp.buf.add_workspace_folder, opts)
    map('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, opts)
    map('n', '<space>wl', function()
      print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, opts)
    map('n', '<space>D', vim.lsp.buf.type_definition, opts)
    map('n', '<space>rn', vim.lsp.buf.rename, opts)
    map({ 'n', 'v' }, '<space>ca', vim.lsp.buf.code_action, opts)
    map('n', 'gr', vim.lsp.buf.references, opts)
    map('n', '<space>f', function()
      vim.lsp.buf.format { async = true }
    end, opts)
  end,
})
