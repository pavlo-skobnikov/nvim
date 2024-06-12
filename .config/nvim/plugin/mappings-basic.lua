-- Clear highlights on escape.
vim.keymap.set('n', '<Esc>', function()
  vim.cmd ':noh'
  vim.cmd ':call clearmatches()'
  vim.lsp.buf.clear_references()
end, { desc = 'Clear highlights and escape' })

-- Center screen after paging through files.
vim.keymap.set('n', '<C-d>', '<C-d>zz', { desc = 'Page down and center screen' })
vim.keymap.set('n', '<C-u>', '<C-u>zz', { desc = 'Page up and center screen' })

-- Trim patches of whitespace to a single space.
vim.keymap.set('n', 'd<Space>', 'f<Space>diwi<Space><Esc>', { desc = 'Delete extra whitespaces' })
vim.keymap.set('n', 'c<Space>', 'f<Space>diwi<Space>', { desc = 'Change extra whitespaces' })

-- Highlight word under cursor.
vim.keymap.set(
  'n',
  'g*',
  function() vim.fn.matchadd('Search', vim.fn.expand '<cword>') end,
  { desc = 'Highlight <cword>' }
)

-- Easily insert from system clipboard in the INSERT mode.
vim.keymap.set('i', '<C-S-i>', '<C-r>*', { desc = "Paste from system' clipboard" })

-- Actions without copying into the default register.
vim.keymap.set('v', '<Leader>D', '"_d', { desc = 'Delete into black hole register' })
vim.keymap.set('v', '<Leader>P', '"_dP', { desc = 'Paste into black hole register' })

-- Insert lines above and below.
vim.keymap.set('n', '[<Space>', 'mzO<Esc>`z', { desc = 'Add line above' })
vim.keymap.set('n', ']<Space>', 'mzo<Esc>`z', { desc = 'Add line below' })
vim.keymap.set('v', '[<Space>', '<Esc>O<Esc>gv', { desc = 'Add line above' })
vim.keymap.set('v', ']<Space>', '<Esc>o<Esc>gv', { desc = 'Add line below' })

-- Quick Lazy UI access.
vim.keymap.set('n', '<Leader>al', ':Lazy<Cr>', { desc = 'Lazy UI', silent = true })

-- Source Neovim configuration files.
vim.keymap.set('n', '<Leader>as', ':source %<Cr>', { desc = 'Source file', silent = true })
vim.keymap.set('v', '<Leader>as', ':source<Cr>', { desc = 'Source selection', silent = true })

-- Work w/ Neovim's Treesitter.
vim.keymap.set('n', '<Leader>ati', ':Inspect<Cr>', { desc = 'Inspect element in Treesitter' })
vim.keymap.set('n', '<Leader>att', ':InspectTree<Cr>', { desc = 'Open Treesitter tree' })
vim.keymap.set('n', '<Leader>ate', ':EditQuery<Cr>', { desc = 'Open Treesitter query editor' })

-- Open the quickfix list and move around it.
vim.keymap.set('n', 'gq', ':copen<Cr>', { desc = 'Open qflist' })
vim.keymap.set('n', ']q', ':cnext<Cr>', { desc = 'Next qflist item' })
vim.keymap.set('n', '[q', ':cprevious<Cr>', { desc = 'Previous qflist item' })
vim.keymap.set('n', ']Q', ':clast<Cr>', { desc = 'Last qflist item' })
vim.keymap.set('n', '[Q', ':cfisrt<Cr>', { desc = 'First qflist item' })
