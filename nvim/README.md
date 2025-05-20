# Neovim Configuration

A modular Neovim configuration with a focus on Go development, featuring auto-pairs, snippets, and modern IDE features.

## Features

- **Modular Structure**: Configuration split into logical modules
- **Auto-Pairs**: Automatically close brackets, parentheses, and quotes
- **Snippets**: Ready-to-use snippets for Go development
- **LSP Support**: Integrated language server support for Go, Python, and more
- **Modern UI**: Beautiful interface with Tokyo Night theme
- **File Navigation**: Easy file browsing with nvim-tree and telescope
- **Git Integration**: Git commands with lazygit
- **AI Assistance**: Codeium integration for AI code suggestions
- **Code Formatting**: Automatic code formatting

## Keybindings

### General
- `<leader>ff`: Find files
- `<leader>tlg`: Live grep (search in files)
- `<leader>t`: Toggle terminal
- `<leader>e`: Toggle file explorer
- `<leader>tt`: Toggle transparency

### Buffers
- `<leader>bd`: Delete buffer
- `<leader>bb`: Next buffer
- `<leader>bp`: Previous buffer

### Code
- `<leader>r`: Run current file (auto-detects filetype)
- `<leader>f`: Format current file
- `<leader>lg`: Open LazyGit

### LSP
- `gd`: Go to definition
- `K`: Show hover information
- `gi`: Go to implementation
- `<leader>rn`: Rename symbol
- `<leader>ca`: Code actions

### Codeium (AI Assistant)
- `<C-g>`: Accept suggestion
- `<C-;>`: Next suggestion
- `<C-,>`: Previous suggestion
- `<C-x>`: Clear suggestions

## Go Snippets

- `main`: Create main function template
- `if`: If statement
- `for`: For loop
- `forr`: For range loop
- `func`: Function definition
- `pr`: fmt.Println()
- `prf`: fmt.Printf()
- `iferr`: Error handling
- `st`: Struct definition
- `meth`: Method definition
- `test`: Test function

## Installation

1. Clone this repository to `~/.config/nvim`
2. Start Neovim
3. Run `:PackerSync` to install all plugins
4. Restart Neovim

## Requirements

- Neovim 0.8+
- Git
- A Nerd Font (for icons)
- Go (for Go development)
- Node.js (for some LSP servers) 