-- Update status line with useful information.

-- Get the current git branch name as a component of the status line.
local function get_git_branch_component()
  local result = vim.fn.system 'git branch --show-current'

  if string.match(result, 'fatal') then return 'NO-GIT' end

  return '(' .. vim.fn.trim(result) .. ')'
end

-- Get the diagnostics count for a given severity.
local function get_diagnostics_count(severity) return #vim.diagnostic.get(0, { severity = severity }) end

local function get_diagnostics_component()
  local map_of_symbols_and_diagnostic_counts = {
    ['💡'] = get_diagnostics_count(vim.diagnostic.severity.HINT),
    ['❕'] = get_diagnostics_count(vim.diagnostic.severity.INFO),
    ['🚧'] = get_diagnostics_count(vim.diagnostic.severity.WARN),
    ['🚨'] = get_diagnostics_count(vim.diagnostic.severity.ERROR),
  }

  local list_of_diagnostic_messages = {}
  for symbol, count in pairs(map_of_symbols_and_diagnostic_counts) do
    table.insert(list_of_diagnostic_messages, symbol .. ': ' .. count)
  end

  return table.concat(list_of_diagnostic_messages, ', ')
end

-- The diagnostics component isn't needed for some buffer types.
-- Decide whether the current buffer needs diagnostics information.
local function does_current_ft_allow_diagnostics()
  local not_allowed_fts = { 'oil', 'fugitive', 'gitcommit', 'help' }

  local current_ft = vim.bo.filetype

  for _, not_allowed_ft in ipairs(not_allowed_fts) do
    if not_allowed_ft == current_ft then return false end
  end

  return true
end

-- Set the status line with the current git branch name and (optionally) diagnostics count.
local function set_status_line()
  local diagnostics_message = ''

  if does_current_ft_allow_diagnostics() then diagnostics_message = get_diagnostics_component() .. '  ' end

  vim.opt.statusline = '%f  %r%m%='
    .. diagnostics_message
    .. '%y'
    .. '  '
    .. get_git_branch_component()
    .. '  '
    .. '%l,%c    %P'
end

vim.api.nvim_create_autocmd({ 'BufEnter', 'DiagnosticChanged' }, {
  group = vim.api.nvim_create_augroup('UpdateStatusLineWithDynamicData', { clear = true }),
  pattern = { '*' },
  callback = set_status_line,
  desc = 'Update the status line with the current git branch name and diagnostics count',
})
