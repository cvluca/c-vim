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

    -- Terminal key handler state
    vim.g.term_key_pending = false  -- Flag for waiting state
    -- Map logical ID (1,2,3...) to actual toggleterm ID
    -- Example: {1: 1, 2: 3, 3: 5} means display shows 1,2,3 but actual IDs are 1,3,5
    vim.g.toggleterm_id_map = {1}
    local current_term_idx = 1  -- Current index in id_map

    -- Auto-register new terminals
    vim.api.nvim_create_autocmd({'TermOpen', 'BufEnter'}, {
      pattern = '*toggleterm#*',
      callback = function(args)
        local bufname = vim.api.nvim_buf_get_name(args.buf)
        local actual_id = bufname:match('toggleterm#(%d+)')
        if actual_id then
          actual_id = tonumber(actual_id)
          local id_map = vim.g.toggleterm_id_map or {}

          -- Check if this terminal is already registered
          local already_registered = false
          for _, id in ipairs(id_map) do
            if id == actual_id then
              already_registered = true
              break
            end
          end

          -- If not registered, add it
          if not already_registered then
            table.insert(id_map, actual_id)
            table.sort(id_map)  -- Keep sorted
            vim.g.toggleterm_id_map = id_map
            vim.cmd('redrawstatus')
          end
        end
      end,
    })

    -- Auto-cleanup terminal IDs when terminal exits or is killed
    vim.api.nvim_create_autocmd({'TermClose', 'BufDelete'}, {
      pattern = '*toggleterm#*',
      callback = function(args)
        local bufname = vim.api.nvim_buf_get_name(args.buf)
        local actual_id = bufname:match('toggleterm#(%d+)')
        if actual_id then
          actual_id = tonumber(actual_id)
          local id_map = vim.g.toggleterm_id_map or {}

          -- Find the logical ID being closed
          local closed_logical_id = nil
          for logical_id, id in ipairs(id_map) do
            if id == actual_id then
              closed_logical_id = logical_id
              break
            end
          end

          if closed_logical_id then
            -- Remove the terminal ID from the map
            table.remove(id_map, closed_logical_id)
            vim.g.toggleterm_id_map = id_map

            -- If there are still terminals left, switch to the left one
            if #id_map > 0 then
              -- Calculate target logical ID (cycle to the right if closing first)
              local target_logical_id
              if closed_logical_id > #id_map then
                -- Closed the last one, go to the new last one
                target_logical_id = #id_map
              else
                -- Closed a middle/first one, stay at same position (which is now the next terminal)
                target_logical_id = closed_logical_id
              end

              -- But if we want to go LEFT, we should go to the previous terminal
              target_logical_id = target_logical_id - 1
              if target_logical_id < 1 then
                target_logical_id = #id_map  -- Cycle to the last one
              end

              current_term_idx = target_logical_id
              local target_actual_id = id_map[target_logical_id]

              -- Switch to the target terminal after a delay to ensure cleanup is done
              vim.defer_fn(function()
                vim.cmd(target_actual_id .. 'ToggleTerm')
                -- Enter terminal mode after switching
                vim.defer_fn(function()
                  if vim.bo.buftype == 'terminal' and vim.fn.mode() ~= 't' then
                    vim.cmd('startinsert')
                  end
                end, 50)
              end, 10)
            else
              -- All terminals closed, reset
              current_term_idx = 1
            end

            vim.cmd('redrawstatus')
          end
        end
      end,
    })

    -- Helper to get current terminal ID
    local function get_current_term_id()
      local bufname = vim.api.nvim_buf_get_name(0)
      local match = bufname:match("toggleterm#(%d+)")
      return match and tonumber(match) or nil
    end

    -- Helper to ensure terminal mode after action
    local function ensure_terminal_mode()
      -- Use defer_fn with a delay to ensure terminal is ready
      vim.defer_fn(function()
        -- Check if we're in a terminal buffer and not already in terminal mode
        if vim.bo.buftype == 'terminal' and vim.fn.mode() ~= 't' then
          vim.cmd('startinsert')
        end
      end, 50)  -- 50ms delay to ensure terminal window is active
    end

    -- Helper to find next available actual terminal ID
    local function get_next_actual_id()
      local id_map = vim.g.toggleterm_id_map or {1}
      local used_ids = {}
      for _, id in ipairs(id_map) do
        used_ids[id] = true
      end
      -- Find first unused ID starting from 1
      for i = 1, 100 do
        if not used_ids[i] then
          return i
        end
      end
      return #id_map + 1
    end

    -- Key handler actions
    local key_actions = {
      ['d'] = function()
        -- Kill current terminal with confirmation
        local current_actual_id = get_current_term_id()
        if not current_actual_id then return end

        -- Find the logical ID for display
        local id_map = vim.g.toggleterm_id_map or {}
        local current_logical_id = nil
        for logical_id, actual_id in ipairs(id_map) do
          if actual_id == current_actual_id then
            current_logical_id = logical_id
            break
          end
        end

        if not current_logical_id then return end

        local choice = vim.fn.confirm(
          'Kill terminal ' .. current_logical_id .. '?',
          "&Yes\n&No",
          2  -- Default to No
        )

        if choice == 1 then  -- Yes
          -- Force close the terminal buffer
          local bufnr = vim.api.nvim_get_current_buf()
          vim.cmd('bdelete! ' .. bufnr)
        end
      end,

      ['c'] = function()
        local id_map = vim.g.toggleterm_id_map or {1}
        if #id_map >= 9 then return end

        -- Get next available actual terminal ID
        local new_actual_id = get_next_actual_id()
        table.insert(id_map, new_actual_id)
        vim.g.toggleterm_id_map = id_map
        current_term_idx = #id_map
        vim.cmd(new_actual_id .. 'ToggleTerm')
        ensure_terminal_mode()
      end,

      ['h'] = function()
        local id_map = vim.g.toggleterm_id_map or {1}
        if #id_map == 0 then return end

        local current_actual_id = get_current_term_id()
        current_term_idx = current_term_idx - 1
        if current_term_idx < 1 then current_term_idx = #id_map end

        local target_actual_id = id_map[current_term_idx]
        if target_actual_id ~= current_actual_id then
          vim.cmd(target_actual_id .. 'ToggleTerm')
          ensure_terminal_mode()
        end
      end,

      ['l'] = function()
        local id_map = vim.g.toggleterm_id_map or {1}
        if #id_map == 0 then return end

        local current_actual_id = get_current_term_id()
        current_term_idx = current_term_idx + 1
        if current_term_idx > #id_map then current_term_idx = 1 end

        local target_actual_id = id_map[current_term_idx]
        if target_actual_id ~= current_actual_id then
          vim.cmd(target_actual_id .. 'ToggleTerm')
          ensure_terminal_mode()
        end
      end,

      ['v'] = function()
        -- View terminal history in a separate buffer
        local term_buf = vim.api.nvim_get_current_buf()
        local term_actual_id = get_current_term_id()
        local lines = vim.api.nvim_buf_get_lines(term_buf, 0, -1, false)

        -- Find logical ID for display
        local bufname = vim.api.nvim_buf_get_name(term_buf)
        local actual_id = tonumber(bufname:match('toggleterm#(%d+)'))
        local logical_id = nil
        if actual_id then
          local id_map = vim.g.toggleterm_id_map or {}
          for lid, aid in ipairs(id_map) do
            if aid == actual_id then
              logical_id = lid
              break
            end
          end
        end

        -- Create new scratch buffer
        vim.cmd('enew')
        local view_buf = vim.api.nvim_get_current_buf()
        vim.api.nvim_buf_set_lines(view_buf, 0, -1, false, lines)

        -- Set buffer options
        vim.bo[view_buf].buftype = 'nofile'
        vim.bo[view_buf].bufhidden = 'wipe'
        vim.bo[view_buf].swapfile = false
        vim.bo[view_buf].modifiable = false

        -- Set buffer name
        local buf_title = 'Terminal ' .. (logical_id or actual_id or '?') .. ' History'
        vim.api.nvim_buf_set_name(view_buf, buf_title)

        -- Move cursor to bottom (latest output)
        vim.cmd('normal! G')

        -- Function to return to terminal
        local function return_to_terminal()
          vim.cmd('close')
          if term_actual_id and vim.api.nvim_buf_is_valid(term_buf) then
            vim.cmd(term_actual_id .. 'ToggleTerm')
            ensure_terminal_mode()
          end
        end

        -- Add keymap to close with q or Esc and return to terminal
        vim.keymap.set('n', 'q', return_to_terminal, { buffer = view_buf, nowait = true })
        vim.keymap.set('n', '<Esc>', return_to_terminal, { buffer = view_buf, nowait = true })
      end,
    }

    -- Add number key actions (1-9) - use logical IDs
    for i = 1, 9 do
      key_actions[tostring(i)] = function()
        local id_map = vim.g.toggleterm_id_map or {1}
        local current_actual_id = get_current_term_id()

        -- Check if logical ID i exists
        if i <= #id_map then
          local target_actual_id = id_map[i]
          if target_actual_id ~= current_actual_id then
            current_term_idx = i
            vim.cmd(target_actual_id .. 'ToggleTerm')
            ensure_terminal_mode()
          end
        end
      end
    end

    -- Helper to set up temporary keymaps and cleanup
    local temp_maps = {}
    local temp_maps_buffer = nil
    local key_watcher_id = nil

    local function cleanup_temp_maps()
      if temp_maps_buffer then
        for _, key in ipairs(temp_maps) do
          pcall(vim.keymap.del, 't', key, { buffer = temp_maps_buffer })
        end
      end
      temp_maps = {}
      temp_maps_buffer = nil

      -- Remove key watcher if exists
      if key_watcher_id then
        vim.on_key(nil, key_watcher_id)
        key_watcher_id = nil
      end

      vim.g.term_key_pending = false
      vim.cmd('redrawstatus')
    end

    -- Configure terminal buffer behavior
    vim.api.nvim_create_autocmd('TermOpen', {
      pattern = '*toggleterm#*',
      callback = function()
        vim.opt_local.scrolloff = 0
        vim.opt_local.bufhidden = 'hide'
      end,
    })

    -- Auto-reset Ctrl-t mode when leaving terminal buffer
    vim.api.nvim_create_autocmd({'BufLeave', 'BufWinLeave'}, {
      pattern = '*toggleterm#*',
      callback = function()
        if vim.g.term_key_pending then
          cleanup_temp_maps()
        end
      end,
    })

    local function create_key_handler(action_fn)
      return function()
        cleanup_temp_maps()
        action_fn()
      end
    end

    -- Start waiting mode with temporary keymaps
    local function start_key_wait()
      -- Clean up any existing temp maps first
      cleanup_temp_maps()

      vim.g.term_key_pending = true
      vim.cmd('redrawstatus')

      -- Store current buffer number
      temp_maps_buffer = vim.api.nvim_get_current_buf()

      -- Valid keys for Ctrl-t mode
      local valid_keys = {
        c = true, d = true, h = true, l = true, v = true,
        ['1'] = true, ['2'] = true, ['3'] = true, ['4'] = true, ['5'] = true,
        ['6'] = true, ['7'] = true, ['8'] = true, ['9'] = true
      }

      -- Set up key watcher to auto-exit on invalid keys
      key_watcher_id = vim.on_key(function(key)
        if not vim.g.term_key_pending then return end

        -- Convert key to readable string
        local key_str = vim.fn.keytrans(key)

        -- Check if it's Ctrl-t or Esc (handled separately)
        local is_ctrl_t = (key == vim.api.nvim_replace_termcodes('<C-t>', true, false, true))
        local is_esc = (key == vim.api.nvim_replace_termcodes('<Esc>', true, false, true))

        -- If it's a valid key or Ctrl-t/Esc, let the keymap handle it
        if valid_keys[key_str] or is_ctrl_t or is_esc then
          return
        end

        -- Invalid key - cleanup and let it pass through
        vim.schedule(function()
          cleanup_temp_maps()
        end)
      end)

      -- Create temporary keymaps for all possible next keys
      local keys_to_map = {'c', 'd', 'h', 'l', 'v', '<C-t>', '<Esc>', '1', '2', '3', '4', '5', '6', '7', '8', '9'}

      for _, key in ipairs(keys_to_map) do
        local action
        if key == '<Esc>' then
          action = function()
            cleanup_temp_maps()
            local escape_keys = vim.api.nvim_replace_termcodes('<C-\\><C-n>', true, false, true)
            vim.api.nvim_feedkeys(escape_keys, 'n', false)
          end
        elseif key == '<C-t>' then
          -- Pressing Ctrl-t again cancels the waiting mode
          action = function()
            cleanup_temp_maps()
          end
        else
          action = create_key_handler(key_actions[key] or function() end)
        end

        vim.keymap.set('t', key, action, { buffer = temp_maps_buffer, nowait = true })
        table.insert(temp_maps, key)
      end
    end

    -- Map Ctrl-t to start waiting mode
    vim.keymap.set('t', '<C-t>', start_key_wait, { desc = 'Terminal key prefix' })
  end
}
