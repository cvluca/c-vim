local M = {}

M.gutentags = function()
  -- Define the callback function for Gutentags status within the same function
  local function gutentags_status_cb(mods)
    local msg = ""

    -- If ctags is active, display the icon and status
    if vim.tbl_contains(mods, 'ctags') then
      local icon = "♨ "
      msg = "%#St_LspHints#" .. icon .. "ctags "
    elseif vim.tbl_contains(mods, 'cscope') then
      local icon = "♺ "
      msg = "%#St_LspHints#" .. icon .. "cscope "
    end

    return msg
  end

  if vim.g.gutentags_enabled then
    -- Use the callback with gutentags#statusline_cb
    return vim.fn['gutentags#statusline_cb'](gutentags_status_cb)
  else
    return ""
  end
end

M.ui = {
  theme = "gruvbox",

  statusline = {
    theme = "default",
    separator_style = "default",
    order = { "mode", "file", "git", "%=", "lsp_msg", "%=", "diagnostics", "lsp", "gutentags", "cwd", "cursor" },
    modules = {
      gutentags = M.gutentags,  -- Use the gutentags function defined earlier
    },
  },
}

return M
