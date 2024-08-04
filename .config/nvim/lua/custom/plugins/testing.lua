return {
  -- A testing framework for Neovim 🧪
  'nvim-neotest/neotest',
  dependencies = {
    'nvim-neotest/nvim-nio',
    'nvim-lua/plenary.nvim',
    'antoinemadec/FixCursorHold.nvim',
    'nvim-treesitter/nvim-treesitter',
    'rcasia/neotest-java',
    'stevanmilic/neotest-scala',
  },
  keys = {
    { '<Leader>rt', function() require('neotest').run.run() end, desc = 'Run nearest test' },
    { '<Leader>rf', function() require('neotest').run.run(vim.fn.expand('%')) end, desc = 'Run tests in file' },
    { '<Leader>rd', function() require('neotest').run.run({ strategy = 'dap' }) end, desc = 'Debug nearest test' },
    { '<Leader>rs', function() require('neotest').run.stop() end, desc = 'Stop the nearest test' },
    { '<Leader>ra', function() require('neotest').run.attach() end, desc = 'Attach to the nearest test' },
  },
  config = function()
    require('neotest').setup({
      adapters = {
        require('neotest-java'),
        require('neotest-scala'),
      },
    })
  end,
}
