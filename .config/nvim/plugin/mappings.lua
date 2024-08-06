-- [[ Aliases ]]

local set_plain = vim.keymap.set
local make_repeatable = require('nvim-treesitter.textobjects.repeatable_move').make_repeatable_move_pair

-- [[ Helper functions ]]

--- Returns a function that can be used as a keymap action to call a VSCode action.
---@param name string
---@param opts table|nil
---@return function: A wrapped function to call the VSCode action with the provided arguments.
local function action_fn(name, opts)
  return function() require('vscode').action(name, opts) end
end

--- Check if the current session is a VSCode one.
---@return boolean: `true` if the current session is a VSCode one, `false` if it's a standalone terminal session.
local function is_vscode_session() return vim.g.vscode and true or false end

--- Set a keymap only for VSCode sessions.
---@param mode string|string[]
---@param lhs string
---@param rhs string|function
---@param opts vim.keymap.set.Opts
local function set_vscode(mode, lhs, rhs, opts)
  if is_vscode_session() then set_plain(mode, lhs, rhs, opts) end
end

--- Set a keymap only for terminal sessions.
---@param mode string|string[]
---@param lhs string
---@param rhs string|function
---@param opts vim.keymap.set.Opts
local function set_term(mode, lhs, rhs, opts)
  if not is_vscode_session() then set_plain(mode, lhs, rhs, opts) end
end

--- Set a keymap with different actions for terminal and VSCode sessions.
---@param mode string|string[]
---@param lhs string
---@param rhs_nvim string|function
---@param rhs_vscode string|function
---@param opts vim.keymap.set.Opts
local function set_both(mode, lhs, rhs_nvim, rhs_vscode, opts)
  if is_vscode_session() then
    set_plain(mode, lhs, rhs_vscode, opts)
  else
    set_plain(mode, lhs, rhs_nvim, opts)
  end
end

-- [[ Mappings for both VSCode and terminal sessions w/ the *same* actions ]]

-- Clear highlights on escape.
set_plain('n', '<Esc>', function()
  vim.cmd(':noh')
  vim.cmd(':call clearmatches()')
end, { desc = 'Clear highlights and escape' })

-- Trim patches of whitespace to a single space.
set_plain('n', 'd<Space>', 'f<Space>diwi<Space><Esc>', { desc = 'Delete extra whitespaces' })
set_plain('n', 'c<Space>', 'f<Space>diwi<Space>', { desc = 'Change extra whitespaces' })

-- Insert lines above and below.
set_plain('n', '[<Space>', 'mzO<Esc>`z', { desc = 'Add line above' })
set_plain('n', ']<Space>', 'mzo<Esc>`z', { desc = 'Add line below' })
set_plain('v', '[<Space>', '<Esc>O<Esc>gv', { desc = 'Add line above' })
set_plain('v', ']<Space>', '<Esc>o<Esc>gv', { desc = 'Add line below' })

-- Actions without copying into the default register.
set_plain('v', '<Leader>D', '"_d', { desc = 'Delete into black hole register' })
set_plain('v', '<Leader>P', '"_dP', { desc = 'Paste into black hole register' })

-- Highlight word under cursor.
set_plain(
  'n',
  'g*',
  function() vim.fn.matchadd('Search', vim.fn.expand('<cword>')) end,
  { desc = 'Highlight <cword>' }
)

-- [[ Mappings for both VSCode and terminal sessions w/ the *different* actions ]]

-- Window traversal.
set_both(
  'n',
  '<C-h>',
  '<C-w><C-h>',
  action_fn('workbench.action.navigateLeft'),
  { desc = 'Move left a split' }
)
set_both(
  'n',
  '<C-j>',
  '<C-w><C-j>',
  action_fn('workbench.action.navigateDown'),
  { desc = 'Move down a split' }
)
set_both(
  'n',
  '<C-k>',
  '<C-w><C-k>',
  action_fn('workbench.action.navigateUp'),
  { desc = 'Move up a split' }
)
set_both(
  'n',
  '<C-l>',
  '<C-w><C-l>',
  action_fn('workbench.action.navigateRight'),
  { desc = 'Move right a split' }
)

-- [[ Mappings for terminal sessions ]]

-- Source and inspect Lua w/ the Neovim runtime.
set_term('n', '<Leader>s', ':source %<Cr>', { desc = 'Source file', silent = true })
set_term('v', '<Leader>s', ':source<Cr>', { desc = 'Source selection', silent = true })
set_term(
  'v',
  '<Leader>i',
  'y:lua print(vim.inspect(<C-r>*))<Cr>',
  { desc = 'Inspect', silent = true }
)

-- Work w/ Neovim's Treesitter.
set_term('n', '<Leader>t', ':Inspect<Cr>', { desc = 'Inspect element in Treesitter' })
set_term('n', '<Leader>T', ':InspectTree<Cr>', { desc = 'Open Treesitter tree' })
set_term('n', '<Leader>e', ':EditQuery<Cr>', { desc = 'Open Treesitter query editor' })

-- Center screen after paging through files.
set_term('n', '<C-d>', '<C-d>zz', { desc = 'Page down and center screen' })
set_term('n', '<C-u>', '<C-u>zz', { desc = 'Page up and center screen' })

-- [[ Mappings for VSCode sessions ]]

-- Activate which-key.
set_vscode({ 'n', 'v' }, '<Leader>', action_fn('whichkey.show'), { desc = 'Toggle which-key' })

-- Debugging.
set_vscode('n', '<F1>', action_fn('workbench.action.debug.continue'), { desc = 'Continue debug' })
set_vscode('n', '<F2>', action_fn('workbench.action.debug.stepInto'), { desc = 'Step into' })
set_vscode('n', '<F3>', action_fn('workbench.action.debug.stepOver'), { desc = 'Step over' })
set_vscode('n', '<F4>', action_fn('workbench.action.debug.stepOut'), { desc = 'Step out' })
set_vscode('n', '<F5>', action_fn('workbench.action.debug.start'), { desc = 'Start debug' })

-- Move to the next/previous searched item.
local next_searched_item, prev_searched_item = make_repeatable(
  action_fn('search.action.focusNextSearchResult'),
  action_fn('search.action.focusPreviousSearchResult')
)

set_vscode('n', ']q', next_searched_item, { desc = 'Next search result' })
set_vscode('n', '[q', prev_searched_item, { desc = 'Previous search result' })

-- Move to the next/previous hunk.
local next_hunk, prev_hunk = make_repeatable(
  action_fn('workbench.action.editor.nextChange'),
  action_fn('workbench.action.editor.previousChange')
)

set_vscode('n', ']c', next_hunk, { desc = 'Next change' })
set_vscode('n', '[c', prev_hunk, { desc = 'Previous change' })

-- Move to the next/previous diagnostic.
local next_diagnostic, prev_diagnostic =
  make_repeatable(action_fn('editor.action.marker.next'), action_fn('editor.action.marker.prev'))

set_vscode('n', ']d', next_diagnostic, { desc = 'Next diagnostic' })
set_vscode('n', '[d', prev_diagnostic, { desc = 'Previous diagnostic' })

-- Move to the next/previous diagnostic across files.
local next_file_diagnostic, prev_file_diagnostic = make_repeatable(
  action_fn('editor.action.marker.nextInFiles'),
  action_fn('editor.action.marker.prevInFiles')
)

set_vscode('n', ']D', next_file_diagnostic, { desc = 'Next diagnostic across files' })
set_vscode('n', '[D', prev_file_diagnostic, { desc = 'Previous diagnostic across files' })

-- References.
set_vscode('n', 'gR', action_fn('editor.action.goToReferences'), { desc = 'References' })

-- Definition.
set_vscode('n', 'gd', action_fn('editor.action.revealDefinition'), { desc = 'Go to definition' })
set_vscode('n', 'gD', action_fn('editor.action.peekDefinition'), { desc = 'Peek definition' })
set_vscode(
  'n',
  '<C-w>gd',
  action_fn('editor.action.revealDefinitionAside'),
  { desc = 'Open definition in a vertical split' }
)

-- Type definition.
set_vscode(
  'n',
  'gh',
  action_fn('editor.action.goToTypeDefinition'),
  { desc = 'Go to type definition' }
)
set_vscode(
  'n',
  'gH',
  action_fn('editor.action.peekTypeDefinition'),
  { desc = 'Peek type definition' }
)

-- Declaration.
set_vscode('n', 'gf', action_fn('editor.action.revealDeclaration'), { desc = 'Go to declaration' })
set_vscode('n', 'gF', action_fn('editor.action.peekDeclaration'), { desc = 'Peek declaration' })

-- Implementation.
set_vscode(
  'n',
  'gm',
  action_fn('editor.action.goToImplementation'),
  { desc = 'Go to implementation' }
)
set_vscode(
  'n',
  'gM',
  action_fn('editor.action.peekImplementation'),
  { desc = 'Peek implementation' }
)

-- Symbols.
set_vscode('n', 'gs', action_fn('workbench.action.gotoSymbol'), { desc = 'Go to symbol' })
set_vscode('n', 'gS', action_fn('workbench.action.showAllSymbols'), { desc = 'Search symbols' })

-- Diagnostics.
set_vscode('n', 'gq', action_fn('workbench.action.problems.focus'), { desc = 'Diagnostics menu' })

-- Actions.
set_vscode('n', 'ga', action_fn('editor.action.quickFix'), { desc = 'Contextual action' })
set_vscode('n', 'gA', action_fn('editor.action.refactor'), { desc = 'Refactor action' })
set_vscode('n', 'gl', action_fn('editor.action.rename'), { desc = 'Rename' })
set_vscode('n', 'gL', action_fn('codelens.showLensesInCurrentLine'), { desc = 'Code lens' })

-- Hierarchy.
set_vscode('n', 'gC', action_fn('editor.showCallHierarchy'), { desc = 'Call hierarchy' })
set_vscode('n', 'gI', action_fn('editor.showIncomingCalls'), { desc = 'Incoming calls' })
set_vscode('n', 'gO', action_fn('editor.showOutgoingCalls'), { desc = 'Outgoing calls' })
set_vscode('n', 'gY', action_fn('editor.showSupertypes'), { desc = 'Go to super types' })
set_vscode('n', 'gy', action_fn('editor.showSubtypes'), { desc = 'Go to subtypes' })

-- Hover information.
set_vscode({ 'n', 'v' }, 'K', action_fn('editor.action.showHover'), { desc = 'Hover' })
set_vscode(
  { 'n', 'v', 'i' },
  '<C-s>',
  action_fn('editor.action.triggerParameterHints'),
  { desc = 'Signature help' }
)
