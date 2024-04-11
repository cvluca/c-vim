local options = {
  lsp_fallback = true,

  formatters_by_ft = {
    lua = { "stylua" },
  },
}

return {
  "stevearc/conform.nvim",
  config = function()
    require("conform").setup(options)
  end,
}
