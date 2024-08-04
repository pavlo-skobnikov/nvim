return {
  -- Navigate seamlessly between Vim and Tmux panes 🪟
  {
    'christoomey/vim-tmux-navigator',
    keys = {
      { '<C-h>', '<Cmd>TmuxNavigateLeft<Cr>', desc = 'Tmux pane/Vim split left' },
      { '<C-j>', '<Cmd>TmuxNavigateDown<Cr>', desc = 'Tmux pane/Vim split down' },
      { '<C-k>', '<Cmd>TmuxNavigateUp<Cr>', desc = 'Tmux pane/Vim split up' },
      { '<C-l>', '<Cmd>TmuxNavigateRight<Cr>', desc = 'Tmux pane/Vim split right' },
    },
    init = function()
      vim.g.tmux_navigator_no_mappings = 1
      vim.g.tmux_navigator_save_on_switch = 2
    end,
  },
  -- Scratch that itch for etherial notes 📓
  {
    'duff/vim-scratch',
    keys = {
      { '<Leader>bb', '<Cmd>Scratch<Cr>', desc = 'Open a scratch buffer' },
      { '<Leader>bs', '<Cmd>Sscratch<Cr>', desc = 'Open a scratch buffer in a split' },
    },
  },
  -- Visualize and navigate through local file modification history 📑
  {
    'mbbill/undotree',
    keys = { { '<Leader>u', '<Cmd>UndotreeToggle<Cr>', desc = 'Undotree' } },
  },
  -- Mapping key descriptions like it's nothing 🎆
  {
    'folke/which-key.nvim',
    event = 'VeryLazy',
    opts = {
      -- Disable the Which-Key window popup icons.
      icons = { mappings = false },
    },
    config = function(_, opts)
      local wk = require('which-key')

      wk.setup(opts)

      wk.add({
        { '<Leader>a', group = 'application' },
        { '<Leader>am', group = 'mason' },
        { '<Leader>at', group = 'treesitter' },
        { '<Leader>b', group = 'buffers' },
        { '<Leader>d', group = 'debug' },
        { '<Leader>f', group = 'files' },
        { '<Leader>g', group = 'git' },
        { '<Leader>h', group = 'hunks' },
        { '<Leader>r', group = 'run' },
        { '<Leader>t', group = 'toggle' },
        { 'gc', group = 'comment' },
        { 'gl', group = 'lsp' },
        { 'gr', group = 'replace' },
        { 'gs', group = 'symbols' },
      })
    end,
  },
}
