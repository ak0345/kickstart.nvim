-- conform.nvim runs formatters (<leader>f); falls back to LSP formatting
vim.pack.add { gh 'stevearc/conform.nvim' }
require('conform').setup {
  notify_on_error = false,
  format_on_save = function(bufnr)
    -- Filetypes to autoformat on save
    local enabled_filetypes = {
      -- lua = true,
      -- python = true,
    }
    if enabled_filetypes[vim.bo[bufnr].filetype] then return { timeout_ms = 500 } end
  end,
  default_format_opts = { lsp_format = 'fallback' },
  formatters_by_ft = {
    -- python = { 'isort', 'black' },
  },
}
vim.keymap.set({ 'n', 'v' }, '<leader>f', function() require('conform').format { async = true } end, { desc = '[F]ormat buffer' })

-- none-ls: exposes CLI tools as an LSP (diagnostics, code actions).
-- Each source is only registered if its executable is on PATH, so missing tools never error.
vim.pack.add { gh 'nvim-lua/plenary.nvim', gh 'nvimtools/none-ls.nvim' }
local null_ls = require 'null-ls'
local b = null_ls.builtins

local sources = { b.code_actions.gitsigns }
local optional = {
  { 'mypy', b.diagnostics.mypy },
  { 'cppcheck', b.diagnostics.cppcheck },
}
for _, entry in ipairs(optional) do
  if vim.fn.executable(entry[1]) == 1 then table.insert(sources, entry[2]) end
end

null_ls.setup { sources = sources }
