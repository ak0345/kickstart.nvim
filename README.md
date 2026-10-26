# nvim config

Personal Neovim config, originally based on [kickstart.nvim](https://github.com/nvim-lua/kickstart.nvim). It uses Neovim's built-in plugin manager `vim.pack`, so it needs **Neovim ≥ 0.12**.

## Install (laptop or HPC)

```bash
git clone https://github.com/ak0345/kickstart.nvim.git ~/.config/nvim && ~/.config/nvim/install.sh
```

`install.sh` backs up any existing `~/.config/nvim`. It then downloads every plugin at the exact versions pinned in `nvim-pack-lock.json`, installs the LSPs and tools through Mason, and builds the treesitter parsers. When it finishes, `nvim` is ready to use. You can run it again later to update to the latest pushed config.

External tools: `git`, `make`, a C compiler (`cc`), `curl` and `tar` are required. These are optional:

| Tool | Used by |
|------|---------|
| `rg` (ripgrep) | Telescope live grep, Obsidian search |
| `lazygit` | `<leader>gg` |
| `jupytext` (`pip install jupytext`) | opening `.ipynb` files |
| `tmux` | vim-slime (`<leader>r…`) |
| LaTeX (`latexmk`) | vimtex |
| a Nerd Font in your terminal | icons (set `vim.g.have_nerd_font = true` in `init.lua`) |

Run `:checkhealth config` to see which tools are missing.

## Layout

```
init.lua                 leader key, nerd-font flag, loads everything below in order
lua/config/options.lua   vim options + diagnostics
lua/config/keymaps.lua   basic keymaps / autocmds
lua/config/pack.lua      vim.pack build hooks, `gh()` helper
lua/plugins/*.lua        one file per area (ui, git, telescope, files, lsp, ...)
nvim-pack-lock.json      pinned plugin versions (commit it after updating)
```

Plugins are added with `vim.pack.add { gh 'owner/repo' }` followed by their `setup()` call. To update all plugins, run `:lua vim.pack.update()`, then commit the new `nvim-pack-lock.json`.

## Plugins and keymaps

| Area | Plugins | Keys |
|------|---------|------|
| Fuzzy find | telescope (+fzf-native, ui-select) | `<leader>sf` files, `<leader>sg` grep, `<leader><leader>` buffers, `<leader>s…` |
| File tree | neo-tree | `\` |
| File explorer | oil.nvim | `-` parent dir |
| LSP | nvim-lspconfig, mason, fidget | `grd` def, `grr` refs, `grn` rename, `gra` action |
| Completion | blink.cmp, LuaSnip | `<C-y>` accept, `<C-space>` menu |
| Formatting | conform.nvim, none-ls | `<leader>f` |
| Treesitter | nvim-treesitter (main) | — |
| Statusline | lualine | — |
| Git | gitsigns, lazygit.nvim, diffview | `<leader>h…` hunks, `<leader>gg` lazygit, `<leader>gd` diff, `<leader>gh` history |
| Diagnostics | trouble.nvim | `<leader>xx`, `<leader>xs`, `<leader>xl`… |
| Notes | obsidian.nvim (only if `$OBSIDIAN_VAULT` or `~/notes` exists) | `<leader>o…` |
| Focus | zen-mode | `<leader>z` |
| Research | vim-slime, jupytext, vimtex | `<leader>rc` cell, `<leader>rl` line, `<leader>rs` selection |
| Misc | which-key, mini (ai, surround, icons), todo-comments, guess-indent, tokyonight | — |
