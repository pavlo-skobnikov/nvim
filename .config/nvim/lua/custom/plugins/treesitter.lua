-- ~Blazingly-fast~ syntax highlighting 🌅
return {
  'nvim-treesitter/nvim-treesitter',
  dependencies = {
    -- Always see the surrounding context even if it's too far up.
    'nvim-treesitter/nvim-treesitter-context',
    -- Additional text objects to play around with.
    'nvim-treesitter/nvim-treesitter-textobjects',
  },
  event = 'BufEnter',
  build = ':TSUpdate',
  opts = {
    -- Parsers required for Treesitter to function.
    ensure_installed = {
      'c',
      'lua',
      'vim',
      'vimdoc',
      'query',
      'comment',
      'git_config',
      'git_rebase',
      'gitattributes',
      'gitcommit',
      'gitignore',
    },
    -- Configurations for adding Treesitter captures as textobjects to Neovim.
    textobjects = {
      select = {
        enable = true,
        -- Automatically jump forward to textobj.
        lookahead = true,
        keymaps = {
          ['ia'] = { query = '@parameter.inner', desc = 'Inner argument' },
          ['aa'] = { query = '@parameter.outer', desc = 'Around argument' },
          ['if'] = { query = '@function.inner', desc = 'Inner function' },
          ['af'] = { query = '@function.outer', desc = 'Around function' },
        },
      },
      swap = {
        enable = true,
        swap_next = {
          [']]a'] = { query = '@parameter.inner', desc = 'Move argument forward' },
          [']]f'] = { query = '@function.outer', desc = 'Move function forward' },
        },
        swap_previous = {
          ['[[a'] = { query = '@parameter.inner', desc = 'Move argument backward' },
          ['[[f'] = { query = '@function.outer', desc = 'Move function backward' },
        },
      },
      move = {
        enable = true,
        -- Add the jumps to the jumplist.
        set_jumps = true,
        goto_next_start = {
          [']a'] = { query = '@parameter.inner', desc = 'Next argument' },
          [']f'] = { query = '@function.outer', desc = 'Next function' },
        },
        goto_previous_start = {
          ['[a'] = { query = '@parameter.inner', desc = 'Previous argument' },
          ['[f'] = { query = '@function.outer', desc = 'Previous function' },
        },
      },
    },
  },
  config = function(_, opts)
    require('nvim-treesitter.configs').setup(opts)

    -- Repeating moves.
    local ts_repeat = require 'nvim-treesitter.textobjects.repeatable_move'

    -- Repeat movement with ; and ,
    --  - ; => Goes to the direction you were moving.
    --  - , => Goes to the opposite direction of where you were moving.
    vim.keymap.set({ 'n', 'x', 'o' }, ';', ts_repeat.repeat_last_move)
    vim.keymap.set({ 'n', 'x', 'o' }, ',', ts_repeat.repeat_last_move_opposite)

    -- Make builtin f, F, t, T also repeatable with ; and ,
    -- NOTE: This is required because we redefined ; and , keys above.
    vim.keymap.set({ 'n', 'x', 'o' }, 'f', ts_repeat.builtin_f_expr, { expr = true })
    vim.keymap.set({ 'n', 'x', 'o' }, 'F', ts_repeat.builtin_F_expr, { expr = true })
    vim.keymap.set({ 'n', 'x', 'o' }, 't', ts_repeat.builtin_t_expr, { expr = true })
    vim.keymap.set({ 'n', 'x', 'o' }, 'T', ts_repeat.builtin_T_expr, { expr = true })
  end,
}
