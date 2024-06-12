return {
  -- A _very_ convenient Git wrapper 🌯
  {
    'tpope/vim-fugitive',
    keys = {
      { '<leader>gg', '<cmd>Git<cr>', desc = 'Fugitive' },
      { '<leader>gl', '<cmd>Git log<cr>', desc = 'Log' },
      { '<leader>gB', '<cmd>Git blame<cr>', desc = 'Toggle blame' },
      { '<leader>gf', '<cmd>Git fetch<cr>', desc = 'Fetch' },
      { '<leader>gp', '<cmd>Git pull<cr>', desc = 'Pull' },
      { '<leader>gP', '<cmd>Git push<cr>', desc = 'Push' },
    },
  },
  -- Git gutter and hunk operations 🕳️
  {
    'lewis6991/gitsigns.nvim',
    dependencies = 'nvim-treesitter/nvim-treesitter-textobjects',
    event = 'BufEnter',
    opts = function()
      return {
        on_attach = function(bufnr)
          local gitsigns = require 'gitsigns'
          local ts_repeat = require 'nvim-treesitter.textobjects.repeatable_move'

          -- Set buffer for `vim.keymap.set` options.
          local function create_opts(desc) return { desc = desc, buffer = bufnr } end

          -- Navigation by hunks.
          local function get_move_hunk_fn(lhs, direction)
            return function()
              if vim.wo.diff then
                vim.cmd.normal { lhs, bang = true }
              else
                gitsigns.nav_hunk(direction)
              end
            end
          end

          local next_hunk_repeat, prev_hunk_repeat =
            ts_repeat.make_repeatable_move_pair(get_move_hunk_fn(']c', 'next'), get_move_hunk_fn('[c', 'prev'))

          vim.keymap.set('n', ']c', next_hunk_repeat, create_opts 'Next change')
          vim.keymap.set('n', '[c', prev_hunk_repeat, create_opts 'Previous change')

          -- Actions.
          vim.keymap.set('n', '<leader>hs', gitsigns.stage_hunk, create_opts 'Stage hunk')
          vim.keymap.set('n', '<leader>hS', gitsigns.stage_buffer, create_opts 'Stage buffer')
          vim.keymap.set('n', '<leader>hu', gitsigns.undo_stage_hunk, create_opts 'Undo stage hunk')
          vim.keymap.set('n', '<leader>hr', gitsigns.reset_hunk, create_opts 'Reset hunk')
          vim.keymap.set('n', '<leader>hR', gitsigns.reset_buffer, create_opts 'Reset buffer')
          vim.keymap.set('n', '<leader>hp', gitsigns.preview_hunk, create_opts 'Preview change')
          vim.keymap.set('n', '<leader>hd', gitsigns.diffthis, create_opts 'Diff this')
          vim.keymap.set('n', '<leader>ht', gitsigns.toggle_deleted, create_opts 'Toggle deleted')

          -- Define hunk text object.
          vim.keymap.set({ 'o', 'x' }, 'ih', ':<C-u>Gitsigns select_hunk<CR>')
        end,
      }
    end,
  },
}
