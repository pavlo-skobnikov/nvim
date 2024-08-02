---@diagnostic disable-next-line: duplicate-set-field
-- It's not you, it's the completion engine 💔
return {
  {
    'hrsh7th/nvim-cmp',
    dependencies = {
      -- Snippet engine.
      {
        'L3MON4D3/LuaSnip',
        build = 'make install_jsregexp',
        config = function()
          local ls = require('luasnip')

          vim.snippet.expand = ls.lsp_expand

          vim.snippet.active = function(filter)
            filter = filter or {}
            filter.direction = filter.direction or 1

            if filter.direction == 1 then
              return ls.expand_or_jumpable()
            else
              return ls.jumpable(filter.direction)
            end
          end

          vim.snippet.jump = function(direction)
            if direction == 1 then
              if ls.expandable() then
                return ls.expand_or_jump()
              else
                return ls.jumpable(1) and ls.jump(1)
              end
            else
              return ls.jumpable(-1) and ls.jump(-1)
            end
          end

          vim.snippet.stop = ls.unlink_current

          ls.config.set_config({ history = true, updateevents = 'TextChanged,TextChangedI', override_builtin = true })

          -- Load custom snippet definition files.
          for _, ft_path in ipairs(vim.api.nvim_get_runtime_file('lua/custom/snippets/*.lua', true)) do
            loadfile(ft_path)()
          end

          -- Key mappings for snippet traversal.
          vim.keymap.set(
            { 'i', 's' },
            '<C-k>',
            function() return vim.snippet.active({ direction = 1 }) and vim.snippet.jump(1) end,
            { silent = true }
          )

          vim.keymap.set(
            { 'i', 's' },
            '<C-j>',
            function() return vim.snippet.active({ direction = -1 }) and vim.snippet.jump(-1) end,
            { silent = true }
          )
        end,
      },
      -- Add VSCode-like symbols to the completion menu.
      'onsails/lspkind.nvim',
      -- Sources.
      'saadparwaiz1/cmp_luasnip',
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-path',
      'hrsh7th/cmp-cmdline',
      'petertriho/cmp-git',
    },
    event = 'InsertEnter',
    init = function()
      vim.opt.completeopt = { 'menu', 'menuone', 'noselect' }
      vim.opt.shortmess:append('c')
    end,
    config = function()
      local cmp = require('cmp')

      cmp.setup({
        formatting = { format = require('lspkind').cmp_format({}) },
        sources = { { name = 'nvim_lsp' }, { name = 'path' }, { name = 'buffer' } },
        mapping = {
          ['<C-n>'] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
          ['<C-p>'] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
          ['<C-y>'] = cmp.mapping(
            cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Insert, select = true }),
            { 'i', 'c' }
          ),
        },

        -- Enable luasnip to handle snippet expansion for nvim-cmp
        snippet = { expand = function(args) vim.snippet.expand(args.body) end },
      })

      -- [[ Sources configuration ]]
      cmp.setup.filetype('gitcommit', { sources = cmp.config.sources({ { name = 'git' } }, { { name = 'buffer' } }) })
      require('cmp_git').setup()

      -- Use buffer source for `/` and `?`.
      cmp.setup.cmdline({ '/', '?' }, { mapping = cmp.mapping.preset.cmdline(), sources = { { name = 'buffer' } } })

      -- Use cmdline & path source for ':'.
      cmp.setup.cmdline(':', {
        mapping = cmp.mapping.preset.cmdline(),
        sources = cmp.config.sources({ { name = 'path' } }, { { name = 'cmdline' }, { name = 'buffer' } }),
        matching = { disallow_symbol_nonprefix_matching = false },
      })
    end,
  },
}
