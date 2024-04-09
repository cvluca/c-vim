require "nvchad.options"

vim.opt.relativenumber = true

vim.opt.swapfile = false

vim.opt.list = true
vim.opt.listchars = {
  tab = "→ ",
  trail = "·",
  precedes = "«",
  extends = "»",
}

vim.cmd([[highlight! WhitespaceEOL ctermbg=grey guibg=grey]])
vim.cmd([[match WhitespaceEOL /\s\+$/]])

vim.cmd([[
  augroup last_cursor_position
    autocmd!
    autocmd BufReadPost *
      \ if line("'\"") > 1 && line("'\"") <= line("$") && &ft !~# 'commit' | execute "normal! g`\"zvzz" | endif
  augroup END
]])

vim.opt.foldcolumn = '1' -- '0' is not bad
vim.opt.foldlevel = 99 -- Using ufo provider need a large value, feel free to decrease the value
vim.opt.foldlevelstart = 99
vim.opt.foldenable = true
vim.opt.fillchars = [[eob: ,fold: ,foldopen:,foldsep: ,foldclose:]]
