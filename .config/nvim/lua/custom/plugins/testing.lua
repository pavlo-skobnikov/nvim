return {
  -- A testing framework for Neovim 🧪
  'nvim-neotest/neotest',
  dependencies = {
    'nvim-neotest/nvim-nio',
    'nvim-lua/plenary.nvim',
    'antoinemadec/FixCursorHold.nvim',
    'nvim-treesitter/nvim-treesitter',
    'rcasia/neotest-java',
  },
  keys = function()
    local neotest = require('neotest')

    return {
      { '<Leader>rt', neotest.run.run, desc = 'Run nearest test' },
      { '<Leader>rf', function() neotest.run.run(vim.fn.expand('%')) end, desc = 'Run tests in file' },
      { '<Leader>rd', function() neotest.run.run({ strategy = 'dap' }) end, desc = 'Debug nearest test' },
      { '<Leader>rs', neotest.run.stop, desc = 'Stop the nearest test' },
      { '<Leader>ra', neotest.run.attach, desc = 'Attach to the nearest test' },
    }
  end,
  opts = {
    adapters = {
      require('neotest-java'),
      require('neotest-scala'),
    },
  },
}
