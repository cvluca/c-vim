return {
  "nvim-telescope/telescope.nvim",
  opts = function()
    local conf = require "nvchad.configs.telescope"
    conf.defaults.prompt_prefix = " ❯  "
    return conf
  end,
}
