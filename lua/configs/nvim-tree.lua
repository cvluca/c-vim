local function nvim_tree_on_attach(bufnr)
  local api = require "nvim-tree.api"

  local function opts(desc)
    return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
  end

  -- default mappings
  api.config.mappings.default_on_attach(bufnr)

  -- custom mappings
  vim.keymap.set('n', 'l',     api.node.open.edit,                    opts('Open'))
  vim.keymap.set('n', 'h',     api.node.open.edit,                    opts('Open'))
  vim.keymap.set('n', '?',     api.tree.toggle_help,                  opts('Help'))
end

return {
  "nvim-tree/nvim-tree.lua",
  opts = {
    git = { enable = true },
  },
  config = function()
    require("nvim-tree").setup {
      on_attach = nvim_tree_on_attach,
    }
  end,
}
