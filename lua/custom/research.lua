-- vim-slime settings have to be set before the plugin loads
vim.g.slime_target = 'tmux'
vim.g.slime_default_config = { socket_name = 'default', target_pane = '{right-of}' }
vim.g.slime_dont_ask_default = 1
vim.g.slime_bracketed_paste = 1
vim.g.slime_cell_delimiter = '# %%'

vim.pack.add {
  'https://github.com/jpalardy/vim-slime',
  'https://github.com/GCBallesteros/jupytext.nvim',
  'https://github.com/sindrets/diffview.nvim',
  'https://github.com/lervag/vimtex',
}

require('jupytext').setup {}

vim.keymap.set('n', '<leader>rc', '<Plug>SlimeSendCell', { desc = 'Run cell' })
vim.keymap.set('n', '<leader>rl', '<Plug>SlimeLineSend', { desc = 'Run line' })
vim.keymap.set('x', '<leader>rs', '<Plug>SlimeRegionSend', { desc = 'Run selection' })
