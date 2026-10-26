-- Detect indentation automatically
vim.pack.add { gh 'NMAC427/guess-indent.nvim' }
require('guess-indent').setup {}

-- Colorscheme
vim.pack.add { gh 'folke/tokyonight.nvim' }
---@diagnostic disable-next-line: missing-fields
require('tokyonight').setup { styles = { comments = { italic = false } } }
vim.cmd.colorscheme 'tokyonight-night'

-- Shows pending keybinds
vim.pack.add { gh 'folke/which-key.nvim' }
require('which-key').setup {
  delay = 0,
  icons = { mappings = vim.g.have_nerd_font },
  spec = {
    { '<leader>s', group = '[S]earch', mode = { 'n', 'v' } },
    { '<leader>t', group = '[T]oggle' },
    { '<leader>h', group = 'Git [H]unk', mode = { 'n', 'v' } },
    { '<leader>g', group = '[G]it' },
    { '<leader>x', group = 'Trouble' },
    { '<leader>o', group = '[O]bsidian' },
    { '<leader>r', group = '[R]un (slime)', mode = { 'n', 'x' } },
    { 'gr', group = 'LSP Actions', mode = { 'n' } },
  },
}

-- Highlight TODO, NOTE, etc in comments
vim.pack.add { gh 'folke/todo-comments.nvim' }
require('todo-comments').setup { signs = false }

-- mini.nvim: icons, better textobjects, surround
vim.pack.add { gh 'nvim-mini/mini.nvim' }
if vim.g.have_nerd_font then
  require('mini.icons').setup()
  MiniIcons.mock_nvim_web_devicons() -- for plugins that expect nvim-web-devicons
end
-- va) / yiiq / ci' ...  (aa/ii avoid clashing with built-in incremental selection)
require('mini.ai').setup { mappings = { around_next = 'aa', inside_next = 'ii' }, n_lines = 500 }
-- saiw) add, sd' delete, sr)' replace surroundings
require('mini.surround').setup()

-- Statusline
vim.pack.add { gh 'nvim-lualine/lualine.nvim' }
local function macro_recording()
  local reg = vim.fn.reg_recording()
  return reg == '' and '' or ('recording @' .. reg)
end
require('lualine').setup {
  options = {
    theme = 'tokyonight',
    icons_enabled = vim.g.have_nerd_font,
    component_separators = vim.g.have_nerd_font and nil or { left = '|', right = '|' },
    section_separators = vim.g.have_nerd_font and nil or { left = '', right = '' },
    globalstatus = true,
  },
  sections = {
    lualine_a = { 'mode' },
    lualine_b = { 'branch', 'diff', 'diagnostics' },
    lualine_c = { { 'filename', path = 1 }, macro_recording },
    lualine_x = { 'lsp_status', 'encoding', 'fileformat', 'filetype' },
    lualine_y = { 'progress' },
    lualine_z = { 'location' },
  },
  extensions = { 'oil', 'neo-tree', 'trouble', 'quickfix', 'man' },
}

-- Distraction-free mode
vim.pack.add { gh 'folke/zen-mode.nvim' }
require('zen-mode').setup {}
vim.keymap.set('n', '<leader>z', '<cmd>ZenMode<CR>', { desc = '[Z]en mode' })
