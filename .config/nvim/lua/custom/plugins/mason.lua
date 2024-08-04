-- A tool to manage installing tools like LSP servers, linters, formatters, etc 📦
return {
  'WhoIsSethDaniel/mason-tool-installer.nvim',
  dependencies = {
    {
      'williamboman/mason.nvim',
      keys = {
        { '<leader>amm', '<cmd>Mason<cr>', desc = 'Open Mason UI' },
        { '<leader>aml', '<cmd>MasonLog<cr>', desc = 'Open Mason logs' },
      },
      opts = {},
    },
  },
  event = 'VeryLazy',
  keys = {
    { '<leader>ami', '<cmd>MasonToolsInstall<cr>', desc = 'Install missing packages' },
    { '<leader>amu', '<cmd>MasonToolsUpdate<cr>', desc = 'Install missing and update present packages' },
    { '<leader>amc', '<cmd>MasonToolsClean<cr>', desc = 'Clean up non-ensured packages' },
  },
  opts = {
    -- Tools that must be installed.
    ensure_installed = {
      -- Shell.
      'bash-language-server',
      'beautysh',
      -- Lua.
      'lua-language-server',
      'stylua',
      -- Clojure
      'clojure-lsp',
      'cljfmt',
      -- Web.
      'html-lsp',
      'css-lsp',
      'typescript-language-server',
      -- Misc.
      'prettierd',
    },
    -- Don't auto-update tool packages.
    auto_update = false,
    -- Perform auto-installation/-update of tools when Neovim starts up.
    run_on_start = true,
    -- The period of delay to wait before trying to install tools
    -- after the start-up of Neovim.
    start_delay = 3000, -- In milliseconds.

    -- Disable all integrations. This just adds extra complexity.
    -- I'm fine w/ using the `Mason`-based names to define the tools.
    integrations = {
      ['mason-lspconfig'] = false,
      ['mason-null-ls'] = false,
      ['mason-nvim-dap'] = false,
    },
  },
}
