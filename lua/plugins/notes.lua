-- Obsidian vault integration. Only activates if the vault directory exists, so machines
-- without a vault (e.g. the HPC) start cleanly. Override the path with $OBSIDIAN_VAULT.
vim.pack.add { gh 'nvim-lua/plenary.nvim', gh 'obsidian-nvim/obsidian.nvim' }

local vault = vim.fs.normalize(vim.env.OBSIDIAN_VAULT or '~/notes')
if vim.fn.isdirectory(vault) == 0 then return end

require('obsidian').setup {
  legacy_commands = false,
  workspaces = { { name = 'notes', path = vault } },
  picker = { name = 'telescope.nvim' },
}

vim.keymap.set('n', '<leader>on', '<cmd>Obsidian new<CR>', { desc = '[O]bsidian [N]ew note' })
vim.keymap.set('n', '<leader>os', '<cmd>Obsidian search<CR>', { desc = '[O]bsidian [S]earch' })
vim.keymap.set('n', '<leader>oq', '<cmd>Obsidian quick_switch<CR>', { desc = '[O]bsidian [Q]uick switch' })
vim.keymap.set('n', '<leader>od', '<cmd>Obsidian today<CR>', { desc = '[O]bsidian [D]aily note' })
vim.keymap.set('n', '<leader>ob', '<cmd>Obsidian backlinks<CR>', { desc = '[O]bsidian [B]acklinks' })
