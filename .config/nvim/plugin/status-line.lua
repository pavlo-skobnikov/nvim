-- Update status line with useful information.

-- Get the current git branch name as a component of the status line.
local function get_git_branch_component()
  local result = vim.fn.system 'git branch --show-current'

  if string.match(result, 'fatal') then return 'NO-GIT' end

  return '(' .. vim.fn.trim(result) .. ')'
end

-- Extend the statusline w/ personal setup.
local function set_status_line()
  vim.opt.statusline = '%f  %r%m%=' .. '%y' .. '  ' .. get_git_branch_component() .. '  ' .. '%l,%c    %P'
end

vim.api.nvim_create_autocmd({ 'BufEnter', 'DiagnosticChanged' }, {
  group = vim.api.nvim_create_augroup('UpdateStatusLineWithDynamicData', { clear = true }),
  pattern = { '*' },
  callback = set_status_line,
  desc = 'Update the status line with the current git branch name and diagnostics count',
})
