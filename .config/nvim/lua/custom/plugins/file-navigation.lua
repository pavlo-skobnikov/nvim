return {
  -- Vim-buffer-like file explorer 🛢️
  {
    'stevearc/oil.nvim',
    lazy = false,
    priority = 999,
    keys = { { '-', '<Cmd>Oil<Cr>', desc = 'file-explorer' } },
    opts = {
      -- Show files and directories that start with ".".
      view_options = { show_hidden = true },
      -- Remap split mappings. Also done to not interfere with vim-tmux-navigator.
      keymaps = {
        ['<C-h>'] = false,
        ['<C-x>'] = 'actions.select_split',
        ['<C-v>'] = 'actions.select_vsplit',
        ['<C-l>'] = false,
        ['<C-r>'] = 'actions.refresh',
      },
    },
  },
  -- Pin and jump between files 🦈
  {
    'ThePrimeagen/harpoon',
    branch = 'harpoon2',
    dependencies = { 'nvim-lua/plenary.nvim' },
    keys = function()
      local harpoon = require('harpoon')

      return {
        -- Manage the list of files.
        { '<C-q>', function() harpoon:list():add() end, desc = 'Add file to Harpoon' },
        { '<C-e>', function() harpoon.ui:toggle_quick_menu(harpoon:list()) end, desc = 'Toggle Harpoon file list' },
        -- Jump directly to specific files.
        { '<C-1>', function() harpoon:list():select(1) end, desc = 'Go to the 1st Harpoon file' },
        { '<C-2>', function() harpoon:list():select(2) end, desc = 'Go to the 2nd Harpoon file' },
        { '<C-3>', function() harpoon:list():select(3) end, desc = 'Go to the 3rd Harpoon file' },
        { '<C-4>', function() harpoon:list():select(4) end, desc = 'Go to the 4th Harpoon file' },
        { '<C-5>', function() harpoon:list():select(5) end, desc = 'Go to the 5th Harpoon file' },
        -- Move between files.
        { '<C-S-p>', function() harpoon:list():prev() end, desc = 'Next Harpoon file' },
        { '<C-S-n>', function() harpoon:list():next() end, desc = 'Previous Harpoon file' },
      }
    end,
    config = function() require('harpoon'):setup() end,
  },
}
