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

M.file = function()
  -- Get the current buffer name
  local bufname = vim.api.nvim_buf_get_name(0)

  -- Check if this is a toggleterm buffer
  if bufname:match("toggleterm#%d+") then
    local current_actual_id = tonumber(bufname:match("toggleterm#(%d+)"))
    local id_map = vim.g.toggleterm_id_map or {1}

    -- Find logical ID from actual ID
    local current_logical_id = nil
    for logical_id, actual_id in ipairs(id_map) do
      if actual_id == current_actual_id then
        current_logical_id = logical_id
        break
      end
    end

    -- Helper function to get running program in a terminal
    local function get_term_program(term_id)
      local ok, terms = pcall(require, "toggleterm.terminal")
      if not ok then return nil end

      local term = terms.get(term_id)
      if not term or not term.job_id then return nil end

      -- Get the child process of the terminal
      local pid = vim.fn.jobpid(term.job_id)
      if not pid then return nil end

      -- Try to get the foreground process command line (child of shell)
      local handle = io.popen("ps -o args= --ppid " .. pid .. " 2>/dev/null | head -n1")
      if handle then
        local cmdline = handle:read("*a"):gsub("^%s+", ""):gsub("%s+$", "")
        handle:close()

        if cmdline ~= "" then
          -- Extract program name from command line
          -- Remove leading path and arguments
          local program = cmdline:match("^([^%s]+)") or cmdline
          program = program:match("([^/]+)$") or program  -- Remove path

          -- Special handling for interpreters
          if program:match("^python") or program:match("^node") or program:match("^ruby") then
            -- Try to get the script name
            local script = cmdline:match("^%S+%s+([^%s%-]+)")
            if script and not script:match("^%-") then
              script = script:match("([^/]+)$") or script  -- Remove path
              return script
            end
          end

          return program
        end
      end

      -- Fallback: get the shell name
      local shell_handle = io.popen("ps -o comm= -p " .. pid .. " 2>/dev/null")
      if shell_handle then
        local shell = shell_handle:read("*a"):gsub("%s+", "")
        shell_handle:close()
        return shell ~= "" and shell or nil
      end

      return nil
    end

    -- Build the display string with all terminal IDs and programs
    -- Use keyboard icon when waiting for Ctrl-t command
    local icon = vim.g.term_key_pending and "⌨️ " or "🖥️ "
    local display = "%#St_file# " .. icon

    -- Display using logical IDs (1, 2, 3...) but get program from actual IDs
    for logical_id, actual_id in ipairs(id_map) do
      local program = get_term_program(actual_id)
      local term_label = tostring(logical_id)
      if program then
        term_label = term_label .. ":" .. program
      end

      if logical_id == current_logical_id then
        -- Highlight current terminal
        display = display .. "%#St_file_info#[" .. term_label .. "]%#St_file# "
      else
        -- Normal display for other terminals
        display = display .. term_label .. " "
      end
    end

    return display
  end

  -- Otherwise, use the default file module from NvChad
  local stbufnr = function()
    return vim.api.nvim_win_get_buf(vim.g.statusline_winid or 0)
  end

  local icon = "  "
  local filename = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(stbufnr()), ":t")

  if filename == "" then
    filename = "Empty"
  else
    local devicons_present, devicons = pcall(require, "nvim-web-devicons")
    if devicons_present then
      local ft_icon = devicons.get_icon(filename)
      icon = (ft_icon ~= nil and ft_icon) or icon
    end
  end

  return "%#St_file# " .. icon .. " " .. filename .. " %#St_file_sep#"
end

M.ui = {
  theme = "gruvbox",

  statusline = {
    theme = "default",
    separator_style = "default",
    order = { "mode", "file", "git", "%=", "lsp_msg", "%=", "diagnostics", "lsp", "gutentags", "cwd", "cursor" },
    modules = {
      file = M.file,  -- Custom file module to beautify toggleterm display
      gutentags = M.gutentags,  -- Use the gutentags function defined earlier
    },
  },
}

return M
