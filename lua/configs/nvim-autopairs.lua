local npairs = require('nvim-autopairs')
-- local Rule = require('nvim-autopairs.rule')
-- local cond = require('nvim-autopairs.conds')

return {
  "windwp/nvim-autopairs",
  event = "InsertEnter",
  config = function()
    -- npairs.add_rule(Rule("$$","$$","tex"))

    npairs.setup({
      disable_filetype = { "TelescopePrompt" , "vim" },
      ignored_next_char = "[%w%.]", -- will ignore alphanumeric and `.` symbol
      fast_wrap = {
        map = '<C-e>',
        end_key = 'm',
      },
    })
  end,
}
