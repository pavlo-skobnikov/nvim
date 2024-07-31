---@diagnostic disable: undefined-field
-- Language-specific plugins for that outstanding Developer Experience™ 👨💻
return {
  {
    'nvim-java/nvim-java',
    ft = { 'java', 'gradle' },
    dependencies = { 'neovim/nvim-lspconfig', 'folke/which-key.nvim', 'hrsh7th/nvim-cmp' },
    keys = function(self, _)
      return {
        -- Project.
        {
          '<Localleader>pb',
          function() require('java').build.build_workspace() end,
          ft = self.ft,
          desc = 'Project build',
        },
        {
          '<Localleader>pr',
          function() require('java').runner.built_in.run_app {} end,
          ft = self.ft,
          desc = 'Run the application',
        },
        { '<Localleader>pR', ':JavaRunnerRunMain<Space>', ft = self.ft, desc = 'Run the application with arguments' },
        {
          '<Localleader>ps',
          function() require('java').runner.built_in.stop_app() end,
          ft = self.ft,
          desc = 'Stop the application',
        },
        {
          '<Localleader>pt',
          function() require('java').built_in.toggle_logs() end,
          ft = self.ft,
          desc = 'Toggle application logs',
        },
        -- Configuration.
        {
          '<Localleader>cd',
          function() require('java').dap.config_dap() end,
          ft = self.ft,
          desc = 'Force DAP reconfiguration',
        },
        { '<Localleader>cp', function() require('java').profile.ui() end, ft = self.ft, desc = 'Open the profiles UI' },
        {
          '<Localleader>cr',
          function() require('java').settings.change_runtime() end,
          ft = self.ft,
          desc = 'Change the JDK version',
        },
        -- Test.
        {
          '<Localleader>tc',
          function() require('java').test.run_current_class() end,
          ft = self.ft,
          desc = 'Run test class',
        },
        {
          '<Localleader>tm',
          function() require('java').test.debug_current_class() end,
          ft = self.ft,
          desc = 'Run test method',
        },
        {
          '<Localleader>tC',
          function() require('java').test.run_current_method() end,
          ft = self.ft,
          desc = 'Debug test class',
        },
        {
          '<Localleader>tM',
          function() require('java').test.debug_current_method() end,
          ft = self.ft,
          desc = 'Debug test method',
        },
        {
          '<Localleader>tl',
          function() require('java').test.view_last_report() end,
          ft = self.ft,
          desc = 'Open the last test report in a popup window',
        },
        -- Refactor.
        {
          '<Localleader>v',
          function() require('java').refactor.extract_variable() end,
          mode = { 'n', 'v' },
          ft = self.ft,
          desc = 'Create a variable',
        },
        {
          '<Localleader>V',
          function() require('java').refactor.extract_variable_all_occurrence() end,
          mode = { 'n', 'v' },
          ft = self.ft,
          desc = 'Create a variable for all occurrences',
        },
        {
          '<Localleader>c',
          function() require('java').refactor.extract_constant() end,
          mode = { 'n', 'v' },
          ft = self.ft,
          desc = 'Create a constant',
        },
        {
          '<Localleader>m',
          function() require('java').refactor.extract_method() end,
          mode = { 'n', 'v' },
          ft = self.ft,
          desc = 'Create a method',
        },
        {
          '<Localleader>f',
          function() require('java').refactor.extract_field() end,
          mode = { 'n', 'v' },
          ft = self.ft,
          desc = 'Create a field',
        },
      }
    end,
    config = function()
      -- Setup the plugin.
      require('java').setup()

      -- Set the language server up w/ capabilities.
      require('lspconfig').jdtls.setup {
        capabilities = require('cmp_nvim_lsp').default_capabilities(),
      }

      -- Add key groups for the plugin mappings.
      require('which-key').add {
        { '<Localleader>p', group = 'project' },
        { '<Localleader>c', group = 'configure' },
        { '<Localleader>t', group = 'test' },
      }
    end,
  },
  {
    'scalameta/nvim-metals',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'j-hui/fidget.nvim',
      'mfussenegger/nvim-dap',
      'nvim-telescope/telescope.nvim',
    },
    ft = { 'scala', 'sbt' },
    opts = function()
      local metals = require 'metals'

      local configuration = metals.bare_config()

      configuration.settings = {
        showImplicitArguments = true,
        init_options = {
          -- Use `fidget.nvim` to show LSP status and notifications
          statusBarProvider = 'off',
        },
        -- Set the language server up w/ capabilities.
        capabilities = require('cmp_nvim_lsp').default_capabilities(),
      }

      configuration.on_attach = function(_, _)
        local telescope = require 'telescope'
        local tvp = require 'metals.tvp'

        -- Configure DAP for Scala.
        -- NOTE: If `jvmOptions`, `args`, or `envFile` is required, then creating customer DAP
        -- clients is a must. Reference: |metals-integrations|
        metals.setup_dap()

        -- All Metals commands.
        vim.keymap.set('n', '<Localleader>c', telescope.extensions.metals.commands, { desc = 'Metals commands' })
        -- Worksheet.
        vim.keymap.set('n', '<Localleader>k', metals.hover_worksheet, { desc = 'Hover worksheet value' })
        vim.keymap.set('n', '<Localleader>w', '<Cmd>MetalsCopyWorksheetOutput<Cr>', { desc = 'Hover worksheet value' })
        -- Hierarchy.
        vim.keymap.set('n', '<Localleader>h', '<Cmd>MetalsSuperMethodHierarchy<Cr>', { desc = 'Hover worksheet value' })
        -- Tree view.
        vim.keymap.set('n', '<Localleader>t', tvp.toggle_tree_view, { desc = 'Hover worksheet value' })
        vim.keymap.set('n', '<Localleader>r', tvp.reveal_in_tree, { desc = 'Hover worksheet value' })
      end

      return configuration
    end,
    config = function(self, opts)
      -- Setup an autocommand to configure and start Metals when entering Scala files.
      vim.api.nvim_create_autocmd('FileType', {
        pattern = self.ft,
        callback = function() require('metals').initialize_or_attach(opts) end,
        group = vim.api.nvim_create_augroup('Metals', { clear = true }),
      })
    end,
  },
  -- Read, evaluate, print, loop 🔁
  {
    'Olical/conjure',
    dependencies = 'folke/which-key.nvim',
    ft = 'clojure',
    init = function()
      -- Enable Conjure's Treesitter integration.
      vim.g['conjure#extract#tree_sitter#enabled'] = true
      -- Rebind the documentation function from K to gk to stop it overriding the
      -- LSP-based information hover.
      vim.g['conjure#mapping#doc_word'] = 'gk'
    end,
    config = function()
      -- Add key groups for the plugin mappings.
      require('which-key').add {
        { '<Localleader>c', group = 'connect' },
        { '<Localleader>e', group = 'evaluate' },
        { '<Localleader>ec', group = 'comment' },
        { '<Localleader>g', group = 'get' },
        { '<Localleader>l', group = 'logs' },
        { '<Localleader>r', group = 'refresh' },
        { '<Localleader>s', group = 'sessions' },
        { '<Localleader>t', group = 'tests' },
        { '<Localleader>v', group = 'variables' },
      }
    end,
  },
}
