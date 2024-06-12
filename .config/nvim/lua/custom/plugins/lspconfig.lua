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
        require('lspconfig')[server_name].setup {
          capabilities = require('cmp_nvim_lsp').default_capabilities(),
        }
      end,
      -- JDTLS Setup is handled by `nvim-java`.
      ['jdtls'] = function() end,
    },
  },
}
