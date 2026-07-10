# Neovim Configuration

Personal Neovim configuration for IDE-like development experience.

## Features

- Treesitter syntax highlighting
- LSP support for multiple languages (Java, Python, Lua, C/C++, Go, TypeScript, etc.)
- Code completion with nvim-cmp
- File explorer with nvim-tree
- Fuzzy finder with Telescope
- Code outline with Aerial
- Sticky context header with treesitter-context
- Git integration with Gitsigns
- Obsidian notes integration
- Jira integration
- AI pair-programming with Claude Code (claudecode.nvim)
- UI/QoL utilities via snacks.nvim
- Fast startup with lazy.nvim

## Requirements

- Neovim >= 0.9.0
- Git
- A Nerd Font (for icons)
- Language servers for LSP support:
  - `jdtls` (Java)
  - `lua_ls` (Lua)
  - `pylsp` (Python)
  - `clangd` (C/C++)
  - `gopls` (Go)
  - `ts_ls` (TypeScript/JavaScript)
  - etc.

## Installation

1. Backup your existing Neovim configuration:
```bash
mv ~/.config/nvim ~/.config/nvim.backup
```

2. Clone this repository:
```bash
git clone https://github.com/AkshayD110/neovim.git ~/.config/nvim
```

3. Start Neovim:
```bash
nvim
```

Lazy.nvim will automatically install all plugins on first launch.

## Configuration

### Environment Variables

Some plugins require environment variables to be set:

#### Jira Plugin
```bash
export JIRA_DOMAIN="your-company.atlassian.net"
export JIRA_USER="your.email@company.com"
export JIRA_PROJECT_KEY="PROJECT"
export JIRA_API_TOKEN="your-api-token"
```

#### Obsidian Plugin
```bash
export OBSIDIAN_VAULT_PATH="$HOME/Documents/ObsidianVault/obsidian-git"
```

Add these to your `~/.zshrc` or `~/.bashrc` file.

## Key Mappings

Leader key: `<Space>`

### General
- `<leader>e` - Toggle file explorer
- `<leader>ff` - Find files
- `<leader>fg` - Live grep
- `<leader>fb` - Find buffers
- `<leader>fc` - Files changed vs `main` branch
- `<leader>gs` - Git status (uncommitted changes)

### LSP
- `gd` - Go to definition
- `gr` - Find references
- `gi` - Go to implementation
- `K` - Hover documentation
- `gh` - Hover documentation
- `<leader>rn` - Rename symbol
- `<leader>ca` - Code actions

### Code Outline
- `<leader>oo` - Toggle code outline
- `<leader>on` - Toggle code outline navigation

### Git
- `<leader>gs` - Git status
- `<leader>gc` - Git commit

### Obsidian Notes
- `<leader>bn` - New note
- `<leader>bs` - Search notes
- `<leader>bq` - Quick switch
- `<leader>bt` - Today's daily note

### Jira
- `<leader>jv` - View Jira issue
- `<leader>jo` - Open Jira issue in browser

### AI / Claude Code
- `<leader>ac` - Toggle Claude
- `<leader>af` - Focus Claude
- `<leader>ar` - Resume Claude session
- `<leader>aC` - Continue Claude session
- `<leader>am` - Select Claude model
- `<leader>ab` - Add current buffer to context
- `<leader>as` - Send selection to Claude (visual mode) / add file (in file tree)
- `<leader>aa` - Accept diff
- `<leader>ad` - Deny diff

## Structure

```
nvim/
├── init.lua                 # Entry point
├── lua/
│   └── aksh/
│       ├── settings.lua     # General settings
│       ├── keymap.lua       # Key mappings
│       ├── lazy.lua         # Plugin manager setup
│       ├── utils.lua        # Utility functions
│       └── plugins/         # Plugin configurations
│           ├── lsp/         # LSP configurations
│           ├── nvim-cmp.lua
│           ├── nvim-tree.lua
│           ├── telescope.lua
│           └── ...
```

## Troubleshooting

### Color Issues

This config ships with `termguicolors` disabled (256-color mode) for broad terminal
compatibility. If your terminal fully supports true color and you want richer colors,
enable it in `lua/aksh/settings.lua`:
```lua
o.termguicolors = true
```

Conversely, if you experience display issues (blue/yellow screens), keep it set to
`false`, which is more compatible with some terminal emulators.

### LSP Not Working

1. Check if the language server is installed:
```bash
which jdtls  # for Java
which lua-language-server  # for Lua
```

2. Check LSP status in Neovim:
```vim
:LspInfo
```

3. Check for errors:
```vim
:messages
```

## License

MIT
