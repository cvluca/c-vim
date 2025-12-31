return {
  "akinsho/toggleterm.nvim",
  lazy = false,
  version = "*",
  config = function()
    require("toggleterm").setup({
      size = 20,
      open_mapping = [[<c-\>]],  -- Ctrl-\ to toggle terminal
      hide_numbers = true,
      shade_terminals = true,
      start_in_insert = true,
      insert_mappings = true,  -- Enable open_mapping in insert mode
      terminal_mappings = true,  -- Enable open_mapping in terminal mode
      persist_size = true,
      direction = 'float',  -- 'vertical' | 'horizontal' | 'tab' | 'float'
      close_on_exit = true,
      shell = vim.o.shell,
      float_opts = {
        border = 'curved',  -- 'single' | 'double' | 'shadow' | 'curved'
        winblend = 0,
      },
    })

    -- Use Esc to exit terminal mode
    vim.keymap.set('t', '<Esc>', [[<C-\><C-n>]], { desc = 'Exit terminal mode' })

    -- Quick window navigation from terminal mode
    vim.keymap.set('t', '<C-h>', [[<Cmd>wincmd h<CR>]], { desc = 'Go to left window' })
    vim.keymap.set('t', '<C-j>', [[<Cmd>wincmd j<CR>]], { desc = 'Go to lower window' })
    vim.keymap.set('t', '<C-k>', [[<Cmd>wincmd k<CR>]], { desc = 'Go to upper window' })
    vim.keymap.set('t', '<C-l>', [[<Cmd>wincmd l<CR>]], { desc = 'Go to right window' })

    -- Quick access to specific terminal instances (Ctrl + number)
    vim.keymap.set({'n', 't'}, '<C-1>', '<Cmd>1ToggleTerm<CR>', { desc = 'Toggle terminal 1' })
    vim.keymap.set({'n', 't'}, '<C-2>', '<Cmd>2ToggleTerm<CR>', { desc = 'Toggle terminal 2' })
    vim.keymap.set({'n', 't'}, '<C-3>', '<Cmd>3ToggleTerm<CR>', { desc = 'Toggle terminal 3' })
  end
}
