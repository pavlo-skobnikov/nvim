-- LSP extravaganza 🎉
return {
  'williamboman/mason-lspconfig.nvim',
  event = 'InsertEnter',
  dependencies = {
    -- LSP clients, all ready to be used 🗣️
    'neovim/nvim-lspconfig',
    -- Show the function signature as you type 🆎
    { 'ray-x/lsp_signature.nvim', opts = {} },
    -- LSP status and notifications.
    { 'j-hui/fidget.nvim', opts = {} },
    -- Show lightbulb when code action is available.
    {
      'kosayoda/nvim-lightbulb',
      opts = {
        autocmd = { enabled = true },
        sign = { enabled = false },
        float = { enabled = true },
      },
    },
    -- Completion framework for the capabilites.
    'hrsh7th/nvim-cmp',
  },
  opts = {
    -- NOTE: The server names provided as keys are the `nvim-lspconfig` server names,
    -- not mason's package names. For example:
    --  - "lua-language-server" => Incorrect ❌
    --  - "lua_ls" => Correct ✅
    handlers = {
      -- The default handler for all language servers.
      function(server_name)
        require('lspconfig')[server_name].setup({
          capabilities = require('cmp_nvim_lsp').default_capabilities(),
        })
      end,
      ['lua_ls'] = function()
        local configuration = {
          capabilities = require('cmp_nvim_lsp').default_capabilities(),
        }

        if string.find(vim.fn.getcwd(), 'nvim') then
          configuration.on_init = function(client)
            local path = client.workspace_folders[1].name
            ---@diagnostic disable-next-line: undefined-field
            if vim.loop.fs_stat(path .. '/.luarc.json') or vim.loop.fs_stat(path .. '/.luarc.jsonc') then return end

            client.config.settings.Lua = vim.tbl_deep_extend('force', client.config.settings.Lua, {
              completion = { callSnippet = 'Replace' },
              hint = { enable = true },
              runtime = { version = 'LuaJIT' },
              workspace = {
                checkThirdParty = false,
                library = {
                  -- Make the server aware of Neovim runtime files.
                  vim.env.VIMRUNTIME,
                  -- Make the server aware of the custom plugins.
                  vim.fn.stdpath('data') .. '/lazy',
                },
              },
            })
          end
          configuration.settings = {
            Lua = {},
          }
        end

        -- If the current neovim session is editing nvim configuration files, then
        -- setup the Lua LSP with extra configuration.
        require('lspconfig').lua_ls.setup(configuration)
      end,
      -- JDTLS Setup is handled by `nvim-java`.
      ['jdtls'] = function() end,
    },
  },
}
