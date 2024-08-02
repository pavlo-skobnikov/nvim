-- Endless fights about meaningless things (i.e. code style) will never stop 👮
return {
  'stevearc/conform.nvim',
  event = 'BufWrite',
  opts = {
    default_format_opts = { lsp_format = 'fallback' },
    format_on_save = { timeout_ms = 500 },
    formatters_by_ft = {
      lua = { 'stylua' },
    },
  },
  keys = { { '<leader>=', function() require('conform').format({}) end, desc = 'Format', mode = { 'n', 'v' } } },
  init = function() vim.o.formatexpr = "v:lua.require'conform'.formatexpr()" end,
}
