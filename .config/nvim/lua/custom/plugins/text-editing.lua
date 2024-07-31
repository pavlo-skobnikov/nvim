return {
  -- A weapon for a more sophisticated situation 👔
  { 'julienvincent/nvim-paredit', ft = 'clojure', opts = {} },
  -- Replace things from the specified register 🪃
  { 'vim-scripts/ReplaceWithRegister', event = 'BufEnter' },
  -- Adds a text object representing the current indentation 🗻
  { 'michaeljsmith/vim-indent-object', event = 'BufEnter' },
  -- The entire buffer as a text object 🌍
  { 'vim-textobj-entire', event = 'BufEnter', dependencies = 'kana/vim-textobj-user' },
  -- `{` and `}` motions now support blank lines 🏃
  { 'dbakker/vim-paragraph-motion', event = 'BufEnter' },
  -- Easy operations on surrounding paired characters 💏
  { 'kylechui/nvim-surround', event = 'BufEnter', opts = {} },
  -- Auto-insert paired characters [^_^]
  { 'windwp/nvim-autopairs', event = 'InsertEnter', opts = {} },
  -- Easy tag manipulation 🏷️
  { 'windwp/nvim-ts-autotag', event = 'BufEnter', opts = {} },
  -- Highlight yanked text 🔦
  { 'machakann/vim-highlightedyank', event = 'BufEnter' },
  -- Auto-highlight of symbols under the cursor 💡
  { 'RRethy/vim-illuminate', event = 'BufEnter' },
  -- The power of rainbows for the delimiters of any programming language 🌈
  { 'HiPhish/rainbow-delimiters.nvim', event = 'BufEnter' },
}
