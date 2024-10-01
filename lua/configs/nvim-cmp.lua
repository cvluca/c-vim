local cmp = require "cmp"

return {
  "hrsh7th/nvim-cmp",
  dependencies = {
    "zbirenbaum/copilot-cmp",
  },
  opts = {
    sources = {
      { name = "copilot",  group_index = 2 },
      { name = "nvim_lsp", group_index = 2 },
      { name = "luasnip",  group_index = 2 },
      { name = "buffer",   group_index = 2 },
      { name = "nvim_lua", group_index = 2 },
      { name = "path",     group_index = 2 },
    },
    mapping = {
      ["<C-p>"] = cmp.mapping.select_prev_item(),
      ["<C-n>"] = cmp.mapping.select_next_item(),
      ["<C-d>"] = cmp.mapping.scroll_docs(-4),
      ["<C-f>"] = cmp.mapping.scroll_docs(4),
      ["<C-Space>"] = cmp.mapping.complete(),
      ["<C-e>"] = cmp.mapping.close(),

      ["<Tab>"] = cmp.mapping.confirm {
        behavior = cmp.ConfirmBehavior.Insert,
        select = true,
      },

      ["<C-j>"] = cmp.mapping(function(fallback)
        if cmp.visible() then
          cmp.select_next_item()
        elseif require("luasnip").expand_or_jumpable() then
          vim.fn.feedkeys(vim.api.nvim_replace_termcodes("<Plug>luasnip-expand-or-jump", true, true, true), "")
        else
          fallback()
        end
      end, { "i", "s" }),

      ["<C-k>"] = cmp.mapping(function(fallback)
        if cmp.visible() then
          cmp.select_prev_item()
        elseif require("luasnip").jumpable(-1) then
          vim.fn.feedkeys(vim.api.nvim_replace_termcodes("<Plug>luasnip-jump-prev", true, true, true), "")
        else
          fallback()
        end
      end, { "i", "s" }),

      ["<CR>"] = cmp.config.disable,
    }
  },
  config = function(_, opts)
    cmp.setup(opts)

    local cmp_autopairs = require('nvim-autopairs.completion.cmp')
    cmp.event:on(
      'confirm_done',
      cmp_autopairs.on_confirm_done()
    )
  end,
}
