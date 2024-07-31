-- Set LSP-based mappings only on callback.
vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('SetLspKeymappings', { clear = true }),
  pattern = { '*' },
  callback = function(e)
    local builtin = require 'telescope.builtin'
    local function create_options(description) return { buffer = e.buf, desc = description } end

    -- GOTOs.
    vim.keymap.set('n', 'gR', builtin.lsp_references, create_options 'References')
    vim.keymap.set('n', 'gd', builtin.lsp_definitions, create_options 'Go to definition')
    vim.keymap.set('n', 'gC', vim.lsp.buf.declaration, create_options 'Go to declaration')
    vim.keymap.set('n', 'gD', builtin.lsp_type_definitions, create_options 'Go to type definition')
    vim.keymap.set('n', 'gI', builtin.lsp_implementations, create_options 'Go to implementation')

    -- Actions.
    vim.keymap.set('n', 'glr', vim.lsp.buf.code_action, create_options 'Refactor action')
    vim.keymap.set('n', 'gla', vim.lsp.codelens.run, create_options 'Contextual action')
    vim.keymap.set('n', 'gln', vim.lsp.buf.rename, create_options 'Rename')
    vim.keymap.set('n', 'glh', vim.lsp.buf.document_highlight, create_options 'Highlight')
    vim.keymap.set('n', 'glf', vim.diagnostic.open_float, create_options 'Float diagnostics')

    -- Symbols.
    vim.keymap.set('n', 'gsd', builtin.lsp_document_symbols, create_options 'Document symbols')
    vim.keymap.set('n', 'gst', builtin.treesitter, create_options 'Treesitter symbols')
    vim.keymap.set('n', 'gsw', builtin.lsp_workspace_symbols, create_options 'Project symbols')
    vim.keymap.set('n', 'gsW', builtin.lsp_dynamic_workspace_symbols, create_options 'Dynamic project symbols')

    -- Diagnostics.
    vim.keymap.set('n', 'gse', function() builtin.diagnostics { bufnr = 0 } end, create_options 'Buffer diagnostics')
    vim.keymap.set('n', 'gsE', builtin.diagnostics, create_options 'Workspace diagnostics')

    -- Call hierarchy.
    vim.keymap.set('n', 'gso', builtin.lsp_outgoing_calls, create_options 'Outgoing calls')
    vim.keymap.set('n', 'gsi', builtin.lsp_incoming_calls, create_options 'Incoming calls')

    -- LSP Information.
    vim.keymap.set({ 'n', 'v' }, 'K', vim.lsp.buf.hover, create_options 'Hover')
    vim.keymap.set({ 'n', 'v', 'i' }, '<C-S-k>', vim.lsp.buf.signature_help, create_options 'Signature help')

    -- Diagnostics movement.
    vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, create_options 'Previous diagnostic')
    vim.keymap.set('n', ']d', vim.diagnostic.goto_next, create_options 'Next diagnostic')
  end,
  desc = 'Set LSP key mappings',
})
