return {
  -- A purrfect theme set 🐈
  {
    'catppuccin/nvim',
    lazy = false,
    priority = 1000,
    init = function() vim.opt.termguicolors = true end,
    opts = {
      flavour = 'frappe',
      background = { light = 'latte', dark = 'frappe' },
      integrations = { harpoon = true, nvim_surround = true, which_key = true },
    },
    config = function(_, opts)
      require('catppuccin').setup(opts)

      vim.cmd('colorscheme catppuccin')
    end,
  },
  -- Auto-switch themes when `System Appearance` setting changes 🌞🌚
  {
    'f-person/auto-dark-mode.nvim',
    event = 'VeryLazy',
    opts = {
      update_interval = 1000,
      set_light_mode = function() vim.cmd('set background=light') end,
      set_dark_mode = function() vim.cmd('set background=dark') end,
    },
  },
}
