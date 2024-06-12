local options = {
  -- [[ General configurations ]]
  -- The encoding written to a file.
  fileencoding = 'utf-8',
  -- Use the system clipboard as the main neovim clipboard.
  clipboard = 'unnamedplus',
  -- Perform autoindenting when writing text.
  smartindent = true,
  -- Set term gui colors (most terminals support this).
  termguicolors = true,
  -- Time to wait for a mapped sequence to complete (in milliseconds).
  timeoutlen = 200,
  -- Flags for short messages.
  shortmess = 'filnxtToOFc',
  -- Which "horizontal" keys are allowed to travel to prev/next line.
  whichwrap = 'bs<>[]hl',
  -- When set case is ignored when completing file names and directories.
  wildignorecase = true,
  -- Bash-like completion in command line.
  wildmode = 'list:longest,full',

  -- [[ Auto-created files by neovim ]]
  -- Don't create a backup file.
  backup = false,
  -- Creates a swapfile.
  swapfile = false,
  -- Don't create a backup file when overwriting a changed file.
  writebackup = false,
  -- Enable persistent undo by saving the undo history to a file.
  undofile = true,

  -- [[ Searching ]]
  -- Ignore case in searches.
  ignorecase = true,
  -- Use smart case in searches.
  smartcase = true,

  -- [[ Splits ]]
  -- Force all horizontal splits to go below current window.
  splitbelow = true,
  -- Force all vertical splits to go to the right of current window.
  splitright = true,

  -- [[ Indentation ]]
  -- Convert tabs to spaces.
  expandtab = true,
  -- How much to (de-)indent when using `<` && `>` operators.
  shiftwidth = 4,
  -- Insert 4 spaces for a tab.
  tabstop = 4,

  -- More space in the neovim command line for displaying messages.
  cmdheight = 1,
  -- Visual marker for column width.
  colorcolumn = '100',
  -- Highlight the current line.
  cursorline = true,
  -- Set numbered lines.
  number = true,
  -- Set relative numbered lines.
  relativenumber = true,

  -- [[ Text wrapping ]]
  -- Don't soft-wrap lines.
  wrap = false,
  -- Don't split words when wrapping.
  linebreak = true,

  -- [[ Hidden characters ]]
  -- Enable displaying hidden characters.
  list = true,
  -- Define which hidden characters to display and their respective symbols.
  listchars = {
    tab = '>·',
    leadmultispace = '⎸   ',
    extends = '▸',
    precedes = '◂',
    trail = '·',
  },

  -- [[ Scroll-off ]]
  -- Minimal number of screen lines to keep above and below the cursor.
  scrolloff = 8,
  -- Minimal number of screen columns either side of cursor if wrap is `false`.
  sidescrolloff = 8,

  -- [[ Folds ]]
  -- Set the the default folded level nesting to be high i.e. most things are unfolded.
  foldlevel = 20,
  -- Define folds by expressions.
  foldmethod = 'expr',
  -- Set fold expression to be defined by treesitter.
  foldexpr = 'nvim_treesitter#foldexpr()',
}

-- Apply the options above.
for k, v in pairs(options) do
  vim.opt[k] = v
end
