#!/usr/bin/env bash
# Install this Neovim config and pre-download everything (plugins, LSPs, treesitter parsers).
#   curl -fsSL https://raw.githubusercontent.com/ak0345/kickstart.nvim/master/install.sh | bash
# or, from a clone:  ./install.sh
set -euo pipefail

REPO="${NVIM_CONFIG_REPO:-https://github.com/ak0345/kickstart.nvim.git}"
CONFIG_DIR="${XDG_CONFIG_HOME:-$HOME/.config}/nvim"

command -v nvim >/dev/null || { echo "nvim not found on PATH" >&2; exit 1; }
command -v git >/dev/null || { echo "git not found on PATH" >&2; exit 1; }
nvim --headless -c 'lua if vim.pack == nil then vim.cmd "cquit" end' -c 'qa' ||
  { echo "Neovim >= 0.12 is required (vim.pack). Found: $(nvim --version | head -1)" >&2; exit 1; }

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]:-$0}")" 2>/dev/null && pwd || true)"
if [ -n "$SCRIPT_DIR" ] && [ -f "$SCRIPT_DIR/init.lua" ] && [ "$SCRIPT_DIR" != "$CONFIG_DIR" ]; then
  SOURCE="$SCRIPT_DIR" # running from a clone somewhere else: symlink it into place
fi

backup_existing() {
  if [ -e "$CONFIG_DIR" ] || [ -L "$CONFIG_DIR" ]; then
    BACKUP="$CONFIG_DIR.bak.$(date +%Y%m%d%H%M%S)"
    echo "Backing up existing $CONFIG_DIR -> $BACKUP"
    mv "$CONFIG_DIR" "$BACKUP"
  fi
  mkdir -p "$(dirname "$CONFIG_DIR")"
}

if [ -n "${SOURCE:-}" ]; then
  if [ "$(readlink "$CONFIG_DIR" 2>/dev/null)" != "$SOURCE" ]; then
    backup_existing
    ln -s "$SOURCE" "$CONFIG_DIR"
  fi
elif [ "$(git -C "$CONFIG_DIR" remote get-url origin 2>/dev/null)" = "$REPO" ]; then
  echo "Updating existing clone at $CONFIG_DIR"
  git -C "$CONFIG_DIR" pull --ff-only
else
  backup_existing
  git clone "$REPO" "$CONFIG_DIR"
fi

echo "==> Installing plugins (vim.pack, pinned by nvim-pack-lock.json)"
echo "==> Installing LSPs/tools via Mason"
nvim --headless -c 'MasonToolsInstallSync' -c 'qa'

echo "==> Building treesitter parsers"
nvim --headless -c "lua require('nvim-treesitter').install(vim.g.ts_parsers):wait(600000)" -c 'qa'

echo
echo "Done. Run 'nvim' and then ':checkhealth config' to see which optional tools are missing"
echo "(rg, lazygit, jupytext, a LaTeX distribution for vimtex...)."
