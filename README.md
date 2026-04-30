# dotfiles

Personal dotfiles for macOS and Linux, managed with [chezmoi](https://www.chezmoi.io/).

Bash shell, Neovim (AstroNvim v5), tmux, and a curated set of CLI tool configs.

## Quick Start

```bash
# One-liner: install chezmoi + apply dotfiles
sh -c "$(curl -fsLS get.chezmoi.io)" -- init --apply hownowbrowncow

# Or if chezmoi is already installed
chezmoi init hownowbrowncow --apply
```

On first run, you'll be prompted for your git name and email. Then the bootstrap
script offers an interactive menu to install tools via Homebrew:

```
  ╔══════════════════════════════════════╗
  ║       Dotfiles Bootstrap             ║
  ╚══════════════════════════════════════╝

  ▸ Detected: macOS (arm64)

  What would you like to install?

  ? Core CLI tools (bash, git, tmux, ripgrep, fd, bat, eza, fzf, jq) [y/N]
  ? Development tools (gh, lazygit, neovim, chezmoi, direnv, shellcheck) [y/N]
  ? Languages & runtimes (node, python, go, rust) [y/N]
  ? Nerd Fonts (Hack, JetBrains Mono, Fira Code) [y/N]
  ? macOS apps (iTerm2, Docker, Rectangle, Raycast) [y/N]
  ? Fun/niche tools (fastfetch, btop, lolcat, cmatrix, pipes) [y/N]
```

## What's Included

### Shell

| Config | Target | Description |
|--------|--------|-------------|
| `dot_bash_profile.tmpl` | `~/.bash_profile` | Primary shell config with git-aware prompt (`[branch !?+*]` indicators), fzf integration, `eza`/`bat` aliases, `extract` function, organized PATH management |
| `dot_bashrc` | `~/.bashrc` | Linux-only shell config (skipped on macOS) |
| `dot_inputrc` | `~/.inputrc` | Readline: case-insensitive completion, Tab/Shift-Tab cycling, Up/Down prefix history search, colored stats |
| `dot_hushlogin` | `~/.hushlogin` | Suppresses "Last login" message on macOS terminal open |

### Editor

| Config | Target | Description |
|--------|--------|-------------|
| `dot_config/nvim/` | `~/.config/nvim/` | **AstroNvim v5** -- full IDE setup (details below) |
| `dot_vimrc` | `~/.vimrc` | Minimal Vim fallback -- sensible defaults, no plugins, Netrw file explorer |

**Neovim highlights:**

- **Language support** -- TypeScript/React via vtsls, ESLint fix-on-save, prettierd formatting, stylelint
- **Themes** -- tokyonight, catppuccin, rose-pine, kanagawa, nightfox
- **Git** -- Neogit (full git UI), Diffview (side-by-side diffs)
- **Testing** -- neotest with jest + vitest adapters
- **AI** -- claude-code.nvim, opencode.nvim
- **Navigation** -- Flash.nvim motion, Neo-tree (auto-close on open, shows dotfiles)
- **Editing** -- todo-comments, autopairs, blink.cmp completion, LuaSnip
- **Leader key** -- `,`

### Git

| Config | Target | Description |
|--------|--------|-------------|
| `dot_gitconfig.tmpl` | `~/.gitconfig` | Templated with name/email. Aliases (`lg`, `go`, `dm`, `pr`, `nuke`, `fixup`, `today`, `undo`), zdiff3 conflicts, histogram diff, rerere, auto-prune, branch sort by recent, `nvim` as editor |
| `dot_config/git/ignore` | `~/.config/git/ignore` | Global gitignore: `.DS_Store`, `.env`, `node_modules/`, IDE dirs, `__pycache__/`, swap files |

### Terminal Multiplexer

| Config | Target | Description |
|--------|--------|-------------|
| `dot_tmux.conf` | `~/.tmux.conf` | Prefix `C-space`, vim-style pane resize, mouse on, 50k scrollback, base-index 1, renumber-windows, tmux2k onedark theme via TPM |

### Tool Configs

| Config | Target | Description |
|--------|--------|-------------|
| `dot_ripgreprc` | `~/.ripgreprc` | Smart-case, follow symlinks, custom type definitions (`web`, `config`, `doc`), glob ignores |
| `dot_config/bat/config` | `~/.config/bat/config` | TwoDark theme, line numbers, git changes |
| `dot_config/lazygit/config.yml` | `~/.config/lazygit/config.yml` | Nerd font icons, nvim as editor, auto-fetch |
| `dot_config/gh/config.yml` | `~/.config/gh/config.yml` | GitHub CLI with `co` alias for `pr checkout` |
| `dot_editorconfig` | `~/.editorconfig` | 2-space indent default, 4-space for C/PHP/Python/Go/Rust, LF endings, UTF-8 |
| `dot_curlrc` | `~/.curlrc` | Auto-referer, compression, 60s timeout, follow redirects |
| `dot_actrc` | `~/.actrc` | GitHub Actions local runner (`act`) secret file config |
| `private_dot_ssh/config` | `~/.ssh/config` | Connection multiplexing, compression, macOS keychain integration, keepalive |

### Linux-Only

| Config | Target | Description |
|--------|--------|-------------|
| `dot_config/i3/config` | `~/.config/i3/config` | i3 window manager: Monokai theme, vim-style keys, Hack font, gaps |
| `dot_config/i3status/config` | `~/.config/i3status/config` | i3status bar: ethernet, time, disk, CPU/memory |
| `dot_gdbinit` | `~/.gdbinit` | Intel disassembly syntax |

### Niche / Fun

| Config | Target | Description |
|--------|--------|-------------|
| `dot_config/fastfetch/config.jsonc` | `~/.config/fastfetch/config.jsonc` | System info display with compact layout |
| `dot_config/btop/btop.conf` | `~/.config/btop/btop.conf` | System monitor with onedark theme |

## Managing Dotfiles

```bash
# Preview what chezmoi would change on your system
chezmoi diff

# Apply all changes
chezmoi apply

# Apply a single file
chezmoi apply ~/.gitconfig

# Edit a managed file (auto-applies on save)
chezmoi edit ~/.bash_profile

# Add a new file to chezmoi management
chezmoi add ~/.some_config

# Pull latest from remote and apply
chezmoi update

# See which files chezmoi manages
chezmoi managed

# Enter the source directory
chezmoi cd
```

### Templating

Files ending in `.tmpl` are [Go templates](https://www.chezmoi.io/user-guide/templating/).
Currently templated:

- **`.gitconfig`** -- injects `name` and `email` from initial setup
- **`.bash_profile`** -- conditional blocks for macOS vs Linux (Homebrew paths, completions, exports)
- **`.chezmoiignore`** -- platform-based file filtering

Template data is stored in `~/.config/chezmoi/chezmoi.toml` after first `chezmoi init`.

## macOS Defaults

A standalone script for macOS system preferences (not auto-applied):

```bash
bash macos_defaults.sh
```

Sets: fast key repeat, tap-to-click, Finder show hidden files/extensions, Dock auto-hide,
screenshots to `~/Screenshots` as PNG, Safari developer tools, and more.

## Brewfile

The `Brewfile` is organized by tagged categories. The bootstrap script parses
these tags to selectively install:

| Tag | Contents |
|-----|----------|
| `core` | bash, git, tmux, ripgrep, fd, bat, eza, fzf, jq, tree, htop, wget, curl, coreutils |
| `dev` | gh, lazygit, neovim, chezmoi, direnv, act, shellcheck |
| `languages` | n (node), python, go, rustup (commented out -- install manually or uncomment) |
| `fonts` | Hack, JetBrains Mono, Fira Code (all Nerd Font variants) |
| `apps` | iTerm2, Docker, Rectangle, Raycast (commented out -- uncomment what you use) |
| `fun` | fastfetch, btop, lolcat, cowsay, fortune, figlet, pipes-sh, cmatrix |

## Structure

```
dotfiles/
├── .chezmoi.toml.tmpl              # chezmoi config template (name, email)
├── .chezmoiignore                  # platform-specific file filtering
├── .gitignore
├── Brewfile                        # categorized Homebrew packages
├── README.md
├── macos_defaults.sh               # macOS system preferences (manual)
├── run_once_before_install.sh.tmpl # bootstrap: Homebrew + interactive install
│
├── dot_bash_profile.tmpl           # → ~/.bash_profile
├── dot_bashrc                      # → ~/.bashrc (Linux)
├── dot_gitconfig.tmpl              # → ~/.gitconfig
├── dot_tmux.conf                   # → ~/.tmux.conf
├── dot_vimrc                       # → ~/.vimrc
├── dot_inputrc                     # → ~/.inputrc
├── dot_editorconfig                # → ~/.editorconfig
├── dot_curlrc                      # → ~/.curlrc
├── dot_ripgreprc                   # → ~/.ripgreprc
├── dot_hushlogin                   # → ~/.hushlogin (macOS)
├── dot_gdbinit                     # → ~/.gdbinit (Linux)
├── dot_actrc                       # → ~/.actrc
│
├── private_dot_ssh/
│   └── config                      # → ~/.ssh/config
│
└── dot_config/
    ├── nvim/                       # → ~/.config/nvim/ (AstroNvim v5)
    │   ├── init.lua                #   lazy.nvim bootstrap
    │   ├── dot_luarc.json          #   → .luarc.json
    │   ├── dot_neoconf.json        #   → .neoconf.json
    │   ├── dot_stylua.toml         #   → .stylua.toml
    │   ├── selene.toml
    │   ├── neovim.yml
    │   └── lua/
    │       ├── lazy_setup.lua      #   AstroNvim v5 + lazy.nvim config
    │       ├── community.lua       #   AstroCommunity imports
    │       ├── polish.lua          #   Post-setup hook (disabled)
    │       └── plugins/
    │           ├── astrocore.lua   #   Options, mappings, features
    │           ├── astrolsp.lua    #   LSP, formatting, ESLint fix-on-save
    │           ├── astroui.lua     #   UI/theme config (disabled)
    │           ├── claude-code.lua #   Claude Code AI integration
    │           ├── opencode.lua    #   OpenCode AI integration
    │           ├── mason.lua       #   Auto-installed tools
    │           ├── neo-tree.lua    #   File explorer
    │           ├── neotest.lua     #   Vitest adapter
    │           ├── none-ls.lua     #   prettierd + stylelint
    │           ├── snacks.lua      #   Picker (filename-first)
    │           ├── treesitter.lua  #   Extra parsers
    │           └── user.lua        #   Example overrides (disabled)
    ├── git/ignore                  # → ~/.config/git/ignore
    ├── bat/config                  # → ~/.config/bat/config
    ├── lazygit/config.yml          # → ~/.config/lazygit/config.yml
    ├── gh/config.yml               # → ~/.config/gh/config.yml
    ├── fastfetch/config.jsonc      # → ~/.config/fastfetch/config.jsonc
    ├── btop/btop.conf              # → ~/.config/btop/btop.conf
    ├── i3/config                   # → ~/.config/i3/config (Linux)
    └── i3status/config             # → ~/.config/i3status/config (Linux)
```
