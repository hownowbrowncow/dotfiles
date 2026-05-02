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
  +======================================+
  |       Dotfiles Bootstrap             |
  +======================================+

  > Detected: macOS (arm64)

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
| `dot_bash_profile.tmpl` | `~/.bash_profile` | Primary shell config (details below) |
| `dot_bashrc` | `~/.bashrc` | Linux-only shell config (skipped on macOS) |
| `dot_inputrc` | `~/.inputrc` | Readline: case-insensitive completion, Tab/Shift-Tab cycling, Up/Down prefix history search, colored stats |
| `dot_hushlogin` | `~/.hushlogin` | Suppresses "Last login" message on macOS terminal open |

**Bash highlights:**

- **Prompt** -- git-aware PS1 with branch name and status indicators (`!` modified, `?` untracked, `+` new, `*` ahead, `>` renamed, `x` deleted)
- **History** -- 50k entries, timestamped, flushed after every command, multi-line commands saved as one entry
- **Shell options** -- `autocd` (cd by typing dir name), `extglob` (extended patterns), `nocaseglob`, `cdspell`, `globstar`
- **CDPATH** -- `cd projectname` from anywhere finds `~/dev/projectname`
- **PATH management** -- remove-then-add helpers guarantee correct ordering even with inherited PATH
- **Modern aliases** -- `eza` for `ls`, `bat` for `cat`, safety aliases (`rm -i`, `mv -i`, `cp -i`)
- **FZF functions** -- `fcd` (fuzzy cd), `fh` (fuzzy history), `fkill` (fuzzy process kill), `gco` (fuzzy git branch checkout)
- **Utility functions** -- `extract` (any archive), `mkcd` (mkdir + cd), `b N` (go back N dirs), `note` (timestamped scratch notes), `cp_p` (copy with progress)
- **Man pages** -- syntax-highlighted via `bat` as `MANPAGER`
- **Integrations** -- fzf (with fd), direnv, Homebrew completions
- **XDG** -- explicit `XDG_CONFIG_HOME`, `XDG_DATA_HOME`, `XDG_STATE_HOME`, `XDG_CACHE_HOME`

### Editor

| Config | Target | Description |
|--------|--------|-------------|
| `dot_config/nvim/` | `~/.config/nvim/` | **AstroNvim v5** -- full IDE setup (details below) |
| `dot_vimrc` | `~/.vimrc` | Minimal Vim fallback -- sensible defaults, no plugins, Netrw file explorer |

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

---

## Bash

### Aliases

| Alias | Command | Description |
|-------|---------|-------------|
| `ls` | `eza --icons --group-directories-first` | Modern ls with icons |
| `ll` | `eza -la --icons --group-directories-first` | Long listing |
| `lt` | `eza --tree --level=2 --icons` | Tree view (2 levels) |
| `cat` | `bat --style=plain --paging=never` | Syntax-highlighted cat |
| `vim` / `vi` | `nvim` | Always use neovim |
| `rm` | `rm -i` | Confirm before delete (bypass with `rm -f`) |
| `mv` | `mv -i` | Confirm before overwrite |
| `cp` | `cp -i` | Confirm before overwrite |
| `..` | `cd ..` | Go up one directory |
| `...` | `cd ../..` | Go up two directories |
| `gs` | `git status -s` | Short git status |
| `gl` | `git lg` | Pretty git log |
| `gd` | `git diff` | Git diff |
| `gp` | `git pull` | Git pull |
| `gc` | `git commit` | Git commit |

### Functions

| Function | Usage | Description |
|----------|-------|-------------|
| `fcd` | `fcd` | Fuzzy directory picker with tree preview (fzf + fd) |
| `fh` | `fh` | Fuzzy history search and re-execute |
| `fkill` | `fkill` | Fuzzy process killer |
| `gco` | `gco` | Fuzzy git branch checkout with log preview |
| `note` | `note "fix the bug"` | Append timestamped note to `~/.notes` |
| `note` | `note` | Read all notes |
| `extract` | `extract file.tar.gz` | Extract any archive format |
| `mkcd` | `mkcd newdir` | Create directory and cd into it |
| `b` | `b 3` | Go back N directories |
| `cp_p` | `cp_p src dst` | Copy with progress bar (rsync) |

### Shell Options

| Option | Description |
|--------|-------------|
| `autocd` | Type a directory name to cd into it (no `cd` prefix needed) |
| `extglob` | Extended globs: `rm !(keep.txt)`, `ls @(*.js\|*.ts)` |
| `nocaseglob` | `ls *.jpg` also matches `*.JPG` |
| `globstar` | `**/*.ts` matches recursively |
| `cdspell` / `dirspell` | Autocorrect typos in cd and directory names |
| `cdable_vars` | `cd VARNAME` works if the variable holds a path |
| `no_empty_cmd_completion` | Tab on empty line does nothing |

### FZF Keybindings (terminal)

| Key | Action |
|-----|--------|
| `Ctrl+T` | Fuzzy file finder (paste path at cursor) |
| `Ctrl+R` | Fuzzy history search |
| `Alt+C` | Fuzzy cd into directory |
| `Tab` / `Shift+Tab` | Cycle through completions (readline) |
| `Up` / `Down` | Search history by current prefix (readline) |
| `Ctrl+Left` / `Ctrl+Right` | Move cursor by word (readline) |

---

## Neovim

AstroNvim v5 with kanagawa-wave theme. Leader key is `,`.

### Plugins

**Language & LSP** -- vtsls (TypeScript), jsonls + SchemaStore, marksman (Markdown), lua-language-server, eslint_d via none-ls, prettierd formatting, stylelint, ts-error-translator (plain English TS errors), inc-rename (live rename preview)

**Themes** -- kanagawa-wave (default), tokyonight, catppuccin, rose-pine, nightfox

**Git** -- gitsigns, neogit, diffview, snacks.lazygit (floating + theme sync), snacks.gitbrowse (open on GitHub)

**Testing** -- neotest with jest + vitest adapters

**AI** -- opencode.nvim, claude-code.nvim

**Navigation** -- flash.nvim (fast jumps), neo-tree (file explorer), aerial (code outline), treesitter-context (pinned function headers), snacks.picker (fuzzy finder)

**Editing** -- mini.surround, mini.ai (enhanced text objects), mini.move (move lines), treesj (split/join), dial.nvim (smart increment), yanky.nvim (yank ring), refactoring.nvim, rainbow-delimiters, todo-comments, autopairs, blink.cmp

**Diagnostics** -- trouble.nvim (pretty diagnostics panel)

**Search** -- grug-far.nvim (project-wide find & replace)

**Visual/UX** -- smooth scrolling, indent guides with animation, scope dimming, word references, zen mode, render-markdown (rich in-buffer rendering), bigfile protection, auto-session-restore

### Keybindings

#### General

| Key | Mode | Action |
|-----|------|--------|
| `,w` | n | Save |
| `,q` | n | Quit window |
| `,Q` | n | Exit AstroNvim |
| `,n` | n | New file |
| `,R` | n | Rename file |
| `,h` | n | Home screen (dashboard) |
| `,.` | n | Toggle scratch buffer |
| `,f.` | n | Select scratch buffer |
| `Ctrl+S` | n | Force write |
| `Ctrl+Q` | n | Force quit |

#### Navigation

| Key | Mode | Action |
|-----|------|--------|
| `s` | n | Flash jump |
| `S` | n | Flash treesitter |
| `]b` / `[b` | n | Next / previous buffer |
| `]d` / `[d` | n | Next / previous diagnostic |
| `]e` / `[e` | n | Next / previous error |
| `]g` / `[g` | n | Next / previous git hunk |
| `]T` / `[T` | n | Next / previous test |
| `Ctrl+H/J/K/L` | n | Navigate splits |
| `Ctrl+Arrow` | n | Resize splits |
| `\|` | n | Vertical split |
| `\` | n | Horizontal split |

#### File Explorer (Neo-tree)

| Key | Mode | Action |
|-----|------|--------|
| `,e` | n | Toggle explorer |
| `,o` | n | Toggle explorer focus |
| `h` / `l` | neo-tree | Parent/child node |
| `ff` / `fF` | neo-tree | Find files / all files in directory |
| `fw` / `fW` | neo-tree | Find words / all words in directory |
| `gS` | neo-tree | Search/replace in directory (grug-far) |

#### Search / Find (`,f`)

| Key | Mode | Action |
|-----|------|--------|
| `,ff` | n | Find files |
| `,fF` | n | Find all files (inc. hidden) |
| `,fw` | n | Find words (grep) |
| `,fW` | n | Find words in all files |
| `,fb` | n | Find buffers |
| `,fc` | n | Find word under cursor |
| `,fg` | n | Find git files |
| `,fh` | n | Find help |
| `,fk` | n | Find keymaps |
| `,fo` | n | Find recent files |
| `,fp` | n | Find projects |
| `,fr` | n | Find registers |
| `,fs` | n | Smart find (buffers/recent/files) |
| `,ft` | n | Find themes / colorschemes |
| `,fu` | n | Find undo history |
| `,fy` | n | Find yanks (paste history) |
| `,fn` | n | Find notifications |
| `,f<CR>` | n | Resume previous search |

#### Search / Replace (`,s` -- grug-far)

| Key | Mode | Action |
|-----|------|--------|
| `,ss` | n | Search/replace workspace |
| `,se` | n | Search/replace filetype |
| `,sf` | n | Search/replace file |
| `,sw` | n | Replace word under cursor |
| `,s` | v | Replace selection |

#### LSP

| Key | Mode | Action |
|-----|------|--------|
| `gd` | n | Go to definition |
| `gD` | n | Go to declaration |
| `gy` | n | Go to type definition |
| `gK` | n | Signature help |
| `gl` | n | Hover diagnostics |
| `,la` | n, x | Code action |
| `,ld` | n | Hover diagnostics |
| `,lD` | n | Search diagnostics |
| `,lf` | n, v | Format buffer |
| `,lr` | n | Rename symbol (live preview) |
| `,lR` | n | Search references |
| `,ls` | n | Search symbols (aerial) |
| `,ll` | n | CodeLens refresh |
| `,cR` | n | Rename file (LSP-aware, updates imports) |

#### Diagnostics / Trouble (`,x`)

| Key | Mode | Action |
|-----|------|--------|
| `,xx` | n | Document diagnostics |
| `,xX` | n | Workspace diagnostics |
| `,xt` | n | Todo list |
| `,xT` | n | Todo / Fix / Fixme |
| `,xQ` | n | Quickfix list (Trouble) |
| `,xL` | n | Location list (Trouble) |
| `Ctrl+T` | picker | Send results to Trouble |

#### Git (`,g`)

| Key | Mode | Action |
|-----|------|--------|
| `,gg` | n | Lazygit (floating terminal) |
| `,gl` | n | Git blame (line) |
| `,gL` | n | Git blame (full) |
| `,gp` | n | Preview git hunk |
| `,gs` | n, v | Stage git hunk |
| `,gS` | n | Stage buffer |
| `,gr` | n, v | Reset git hunk |
| `,gR` | n | Reset buffer |
| `,gd` | n | View git diff |
| `,gb` | n | Git branches |
| `,gc` | n | Git commits |
| `,gC` | n | Git commits (current file) |
| `,gt` | n | Git status |
| `,go` | n, x | Open on GitHub |
| `,gnt` | n | Neogit (tab) |

#### Editing

| Key | Mode | Action |
|-----|------|--------|
| `gza` | n, v | Add surrounding |
| `gzd` | n | Delete surrounding |
| `gzr` | n | Replace surrounding |
| `+` / `-` | n, v | Smart increment / decrement (booleans, dates, semver, case) |
| `Alt+H/J/K/L` | n, v | Move line/selection left/down/up/right |
| `,m` | n | Toggle split/join (single-line / multi-line) |
| `,/` | n, x | Toggle comment |
| `[y` / `]y` | n | Cycle yank history (backward / forward) |

##### Text Objects (mini.ai)

| Key | Action |
|-----|--------|
| `daa` | Delete around argument |
| `cia` | Change inside argument |
| `viq` | Select inside any quote |
| `dab` | Delete around brackets |
| `vit` | Select inside tag |

#### Refactoring (`,r`)

| Key | Mode | Action |
|-----|------|--------|
| `,re` | v | Extract function |
| `,rf` | v | Extract function to file |
| `,rv` | v | Extract variable |
| `,ri` | n, v | Inline variable |
| `,rr` | v | Select refactor |

#### Testing (`,T`)

| Key | Mode | Action |
|-----|------|--------|
| `,Tt` | n | Run test |
| `,Td` | n | Debug test |
| `,Tf` | n | Run all tests in file |
| `,Tp` | n | Run all tests in project |
| `,T<CR>` | n | Test summary |
| `,To` | n | Output hover |

#### Buffer Management (`,b`)

| Key | Mode | Action |
|-----|------|--------|
| `,c` | n | Close buffer |
| `,C` | n | Force close buffer |
| `,bc` | n | Close all except current |
| `,bC` | n | Close all buffers |
| `,bd` | n | Close buffer from tabline |
| `,bl` / `,br` | n | Close all left / right |

#### Terminal (`,t`)

| Key | Mode | Action |
|-----|------|--------|
| `,tf` | n | Floating terminal |
| `,th` | n | Horizontal split terminal |
| `,tv` | n | Vertical split terminal |
| `,tl` | n | Lazygit |
| `,tn` | n | Node REPL |
| `,tp` | n | Python REPL |
| `F7` / `Ctrl+'` | n, t, i | Toggle terminal |

#### UI Toggles (`,u`)

| Key | Mode | Action |
|-----|------|--------|
| `,ud` | n | Toggle dim mode |
| `,uf` | n | Toggle format-on-save (buffer) |
| `,uF` | n | Toggle format-on-save (global) |
| `,uh` | n | Toggle inlay hints (buffer) |
| `,ui` | n | Change indent setting |
| `,ul` | n | Toggle statusline |
| `,un` | n | Change line numbering |
| `,us` | n | Toggle spellcheck |
| `,uS` | n | Toggle smooth scroll |
| `,ut` | n | Toggle tabline |
| `,uT` | n | Toggle treesitter context |
| `,uw` | n | Toggle word references |
| `,uZ` | n | Toggle zen mode |
| `,u\|` | n | Toggle indent guides |
| `,u(` | n | Toggle rainbow delimiters |
| `,uY` | n | Toggle semantic highlight |

#### AI

| Key | Mode | Action |
|-----|------|--------|
| `Ctrl+A` | n, x | Ask opencode |
| `Ctrl+X` | n, x | Select opencode action |
| `Ctrl+.` | n, t | Toggle opencode |
| `go` | n, x | Add range to opencode |
| `goo` | n | Add line to opencode |
| `Ctrl+,` | n, t | Toggle Claude Code |

---

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
| `dev` | gh, lazygit, bob (neovim version manager), chezmoi, direnv, act, shellcheck |
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
├── dot_bash_profile.tmpl           # -> ~/.bash_profile
├── dot_bashrc                      # -> ~/.bashrc (Linux)
├── dot_gitconfig.tmpl              # -> ~/.gitconfig
├── dot_tmux.conf                   # -> ~/.tmux.conf
├── dot_vimrc                       # -> ~/.vimrc
├── dot_inputrc                     # -> ~/.inputrc
├── dot_editorconfig                # -> ~/.editorconfig
├── dot_curlrc                      # -> ~/.curlrc
├── dot_ripgreprc                   # -> ~/.ripgreprc
├── dot_hushlogin                   # -> ~/.hushlogin (macOS)
├── dot_gdbinit                     # -> ~/.gdbinit (Linux)
├── dot_actrc                       # -> ~/.actrc
│
├── private_dot_ssh/
│   └── config                      # -> ~/.ssh/config
│
└── dot_config/
    ├── nvim/                       # -> ~/.config/nvim/ (AstroNvim v5)
    │   ├── init.lua                #   lazy.nvim bootstrap
    │   └── lua/
    │       ├── lazy_setup.lua      #   AstroNvim v5 + lazy.nvim config
    │       ├── community.lua       #   AstroCommunity imports
    │       └── plugins/
    │           ├── astrocore.lua   #   Options, mappings, UI toggles
    │           ├── astrolsp.lua    #   LSP config, formatting
    │           ├── astroui.lua     #   Theme (kanagawa-wave)
    │           ├── opencode.lua    #   OpenCode AI integration
    │           ├── claude-code.lua #   Claude Code AI integration
    │           ├── mason.lua       #   Auto-installed tools
    │           ├── neo-tree.lua    #   File explorer
    │           ├── neotest.lua     #   Vitest adapter
    │           ├── none-ls.lua     #   eslint_d + prettierd + stylelint
    │           ├── snacks.lua      #   Scroll, dim, indent, lazygit, scratch
    │           ├── treesitter.lua  #   Parsers + TS/TSX indent fix
    │           └── aerial.lua      #   Code outline (version ^3)
    ├── git/ignore                  # -> ~/.config/git/ignore
    ├── bat/config                  # -> ~/.config/bat/config
    ├── lazygit/config.yml          # -> ~/.config/lazygit/config.yml
    ├── gh/config.yml               # -> ~/.config/gh/config.yml
    ├── fastfetch/config.jsonc      # -> ~/.config/fastfetch/config.jsonc
    ├── btop/btop.conf              # -> ~/.config/btop/btop.conf
    ├── i3/config                   # -> ~/.config/i3/config (Linux)
    └── i3status/config             # -> ~/.config/i3status/config (Linux)
```
