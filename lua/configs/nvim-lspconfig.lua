-- local configs = require("nvchad.configs.lspconfig")

local on_attach = function ()
  vim.diagnostic.config({
    virtual_text = false
  })
  vim.api.nvim_create_autocmd("CursorHold", {
    buffer = bufnr,
    callback = function()
      local opts = {
        focusable = false,
        close_events = { "BufLeave", "CursorMoved", "InsertEnter", "FocusLost" },
        border = 'rounded',
        source = 'always',
        prefix = ' ',
        scope = 'cursor',
      }
      vim.diagnostic.open_float(nil, opts)
    end
  })
end
-- local on_attach = configs.on_attach
-- local on_init = configs.on_init
-- local capabilities = configs.capabilities

local lspconfig = require "lspconfig"

-- local servers = { "lua_ls" }

return  {
  "neovim/nvim-lspconfig",
  config = function()
    require("nvchad.configs.lspconfig").defaults()

    -- for _, lsp in ipairs(servers) do
    --   lspconfig[lsp].setup {
    --     on_init = on_init,
    --     on_attach = on_attach,
    --     capabilities = capabilities,
    --   }
    -- end
    --
    lspconfig.lua_ls.setup {
        on_init = function(client)
        local path = client.workspace_folders[1].name
        if vim.loop.fs_stat(path..'/.luarc.json') or vim.loop.fs_stat(path..'/.luarc.jsonc') then
          return
        end

        client.config.settings.Lua = vim.tbl_deep_extend('force', client.config.settings.Lua, {
          runtime = {
            -- Tell the language server which version of Lua you're using
            -- (most likely LuaJIT in the case of Neovim)
            version = 'LuaJIT'
          },
          -- Make the server aware of Neovim runtime files
          workspace = {
            checkThirdParty = false,
            library = {
              vim.env.VIMRUNTIME
              -- Depending on the usage, you might want to add additional paths here.
              -- "${3rd}/luv/library"
              -- "${3rd}/busted/library",
            }
            -- or pull in all of 'runtimepath'. NOTE: this is a lot slower
            -- library = vim.api.nvim_get_runtime_file("", true)
          }
        })
      end,
      settings = {
        Lua = {}
      },
      on_attach = on_attach,
    }

    lspconfig.ccls.setup {
      init_options = {
        compilationDatabaseDirectory = "build";
        index = {
          threads = 0;
        };
        clang = {
          excludeArgs = { "-frounding-math"} ;
        };
        cache = {
          directory = "/tmp/ccls-cache";
        };
      },
      offsetEncoding = {"utf-8", "utf-16"},
      on_attach = on_attach,
    }
  end,
}
