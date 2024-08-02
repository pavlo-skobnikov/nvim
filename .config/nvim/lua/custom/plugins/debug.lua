---@diagnostic disable: undefined-field, missing-fields
-- Bugs or features?.. That is the question 🐛
return {
  {
    'mfussenegger/nvim-dap',
    dependencies = {
      { 'theHamsta/nvim-dap-virtual-text', opts = {} },
      { 'rcarriga/nvim-dap-ui', dependencies = 'nvim-neotest/nvim-nio' },
    },
    keys = function()
      local dap = require('dap')
      local widgets = require('dap.ui.widgets')
      local dapui = require('dapui')

      return {
        -- Breakpoints.
        { '<Leader>db', dap.toggle_breakpoint, desc = 'Toggle breakpoint' },
        {
          '<Leader>dp',
          function() dap.set_breakpoint(nil, nil, vim.fn.input('Log point message: ')) end,
          desc = 'Toggle print log breakpoint',
        },
        { '<Leader>df', dap.list_breakpoints, desc = 'Find breakpoints' },

        -- Run debug configurations.
        { '<F1>', dap.continue, desc = 'Resume application' },
        { '<F2>', dap.step_into, desc = 'Step into' },
        { '<F3>', dap.step_over, desc = 'Step over' },
        { '<F4>', dap.step_out, desc = 'Step out' },
        { '<F5>', dap.step_back, desc = 'Step back' },

        { '<Leader>dc', dap.run_to_cursor, desc = 'Run to cursor' },

        { '<Leader>dR', dap.restart, desc = 'Restart the debug configuration' },
        { '<Leader>dL', dap.run_last, desc = 'Rerun the last debug configuration' },

        -- Extra interaction w/ the debug session.
        { '<Leader>dr', dap.repl.open, desc = 'Open DAP REPL' },
        { '<Leader>d?', widgets.hover, mode = { 'n', 'v' }, desc = 'Evaluate expression under cursor' },
        { '<Leader>dt', dapui.toggle, desc = 'Toggle DAP UI' },
        { '<Leader>df', function() widgets.centered_float(widgets.frames) end, desc = 'View frames' },
        { '<Leader>ds', function() widgets.centered_float(widgets.scopes) end, desc = 'View scopes' },
      }
    end,
    config = function()
      -- Open DAP UI when starting to debug.
      local dap, dapui = require('dap'), require('dapui')

      dap.listeners.before.attach.dapui_config = dapui.open
      dap.listeners.before.launch.dapui_config = dapui.open

      -- Make the breakpoints use the emoji for visibility.
      vim.fn.sign_define('DapBreakpoint', { text = '🛑', texthl = '', linehl = '', numhl = '' })
    end,
  },
}
