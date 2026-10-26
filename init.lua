-- Neovim config (built on kickstart.nvim, using the built-in `vim.pack` plugin manager)
-- Requires Neovim >= 0.12. Run `:checkhealth config` to check external tools.

vim.loader.enable()

-- Must be set before any plugin loads
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Set to true if your terminal uses a Nerd Font (enables icons everywhere)
vim.g.have_nerd_font = false

require 'config.options'
require 'config.keymaps'
require 'config.pack'

-- Plugins (order matters: earlier modules provide deps for later ones)
require 'plugins.ui' -- colorscheme, which-key, mini, lualine, todo-comments, zen-mode
require 'plugins.git' -- gitsigns, lazygit, diffview
require 'plugins.telescope' -- fuzzy finder
require 'plugins.files' -- neo-tree, oil
require 'plugins.lsp' -- lspconfig, mason, fidget
require 'plugins.completion' -- LuaSnip, blink.cmp
require 'plugins.formatting' -- conform, none-ls
require 'plugins.treesitter'
require 'plugins.trouble'
require 'plugins.notes' -- obsidian
require 'plugins.research' -- vim-slime, jupytext, vimtex

-- vim: ts=2 sts=2 sw=2 et
