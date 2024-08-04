-- An incredibly extendable fuzzy finder 🔭
return {
  'nvim-telescope/telescope.nvim',
  branch = '0.1.x',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-tree/nvim-web-devicons',
    -- UI picker extension for Telescope
    'nvim-telescope/telescope-ui-select.nvim',
    -- Blazingly-fast C port of FZF for Telescope.
    { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
  },
  keys = function()
    local builtin = require('telescope.builtin')

    return {
      { '<C-s>', builtin.current_buffer_fuzzy_find, desc = 'Fuzzy search in buffer' },
      { '<Leader>,', builtin.buffers, desc = 'Switch buffers' },
      { '<Leader>.', function() builtin.find_files({ hidden = true }) end, desc = 'Search files' },
      { '<Leader>/', builtin.live_grep, desc = 'Grep files' },
      { '<Leader>:', builtin.commands, desc = 'Search and execute commands' },
      { '<Leader>q', builtin.quickfix, desc = 'Quickfix list' },
      { '<Leader>Q', builtin.quickfixhistory, desc = 'Quickfix list history' },
      { '<Leader><Leader>', builtin.resume, desc = 'Resume previous search' },
      -- Application.
      { '<Leader>aT', builtin.builtin, desc = 'Search Telescope actions' },
      { '<Leader>ah', builtin.help_tags, desc = 'Search Neovim help tags' },
      -- Git.
      { '<Leader>g.', builtin.git_files, desc = 'Search tracked files' },
      { '<Leader>gc', builtin.git_commits, desc = 'Search commits' },
      { '<Leader>gh', builtin.git_bcommits, desc = 'Search buffer commit history' },
      { '<Leader>gb', builtin.git_branches, desc = 'Search branches' },
      { '<Leader>gs', builtin.git_stash, desc = 'Search stash' },
      -- Files.
      { '<Leader>fr', builtin.oldfiles, desc = 'Find recent files' },
      {
        '<Leader>ff',
        function() builtin.find_files({ hidden = true, no_ignore = true }) end,
        desc = 'Search all files',
      },
    }
  end,
  opts = {
    defaults = {
      dynamic_preview_title = true,
      path_display = { 'tail' },
      layout_strategy = 'vertical',
      layout_config = { vertical = { mirror = false } },
      pickers = { lsp_incoming_calls = { path_display = 'tail' } },
      vimgrep_arguments = {
        'rg',
        '--color=never',
        '--no-heading',
        '--with-filename',
        '--line-number',
        '--column',
        '--smart-case',
        '--hidden',
      },
    },
    extensions = { fzf = {} },
  },
  config = function(_, opts)
    local telescope = require('telescope')

    telescope.setup(opts)

    telescope.load_extension('fzf')
    telescope.load_extension('ui-select')
  end,
}
