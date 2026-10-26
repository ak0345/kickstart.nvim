-- File tree: `\` toggles it
vim.pack.add {
  { src = gh 'nvim-neo-tree/neo-tree.nvim', version = vim.version.range '*' },
  gh 'nvim-lua/plenary.nvim',
  gh 'MunifTanjim/nui.nvim',
}
vim.keymap.set('n', '\\', '<Cmd>Neotree reveal<CR>', { desc = 'NeoTree reveal', silent = true })
require('neo-tree').setup {
  filesystem = {
    hijack_netrw_behavior = 'disabled', -- let oil handle `nvim .` / `:e dir`
    window = { mappings = { ['\\'] = 'close_window' } },
  },
}

-- Edit the filesystem like a buffer: `-` opens the parent directory
vim.pack.add { gh 'stevearc/oil.nvim' }
require('oil').setup {
  default_file_explorer = true,
  columns = vim.g.have_nerd_font and { 'icon' } or {},
  view_options = { show_hidden = true },
}
vim.keymap.set('n', '-', '<cmd>Oil<CR>', { desc = 'Open parent directory (oil)' })
