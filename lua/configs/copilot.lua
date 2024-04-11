local options = {
  suggestions = {
    enabled = false,
  },
  panel = {
    enabled = false,
  },
}

return {
  "zbirenbaum/copilot.lua",
  event = "InsertEnter",
  config = function()
    require("copilot").setup(options)
  end,
}
