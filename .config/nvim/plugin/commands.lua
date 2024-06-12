-- Set the tab spaces and all the related options correctly.
vim.api.nvim_create_user_command('SetTabSpaces', function(opts)
  local spaces_count = tonumber(opts.fargs[1])

  vim.opt.shiftwidth = spaces_count
  vim.opt.tabstop = spaces_count
  vim.opt.listchars = {
    tab = '>·',
    leadmultispace = '⎸' .. string.rep(' ', spaces_count - 1),
    extends = '▸',
    precedes = '◂',
    trail = '·',
  }
end, { nargs = 1 })
