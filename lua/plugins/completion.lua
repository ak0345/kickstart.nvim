-- Snippet engine
vim.pack.add { { src = gh 'L3MON4D3/LuaSnip', version = vim.version.range '2.*' } }
require('luasnip').setup {}

-- Autocompletion. Keys ('default' preset): <C-y> accept, <C-space> menu/docs,
-- <C-n>/<C-p> select, <C-e> hide, <C-k> signature, <Tab>/<S-Tab> jump in snippets.
vim.pack.add { { src = gh 'saghen/blink.cmp', version = vim.version.range '1.*' } }
require('blink.cmp').setup {
  keymap = { preset = 'default' },
  appearance = { nerd_font_variant = 'mono' },
  completion = { documentation = { auto_show = false, auto_show_delay_ms = 500 } },
  sources = { default = { 'lsp', 'path', 'snippets' } },
  snippets = { preset = 'luasnip' },
  -- Pure-Lua matcher: no prebuilt binary download needed (good for HPC nodes)
  fuzzy = { implementation = 'lua' },
  signature = { enabled = true },
}
