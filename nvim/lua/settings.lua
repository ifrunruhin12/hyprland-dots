-- General Settings
vim.o.number = true               -- Enable line numbers
vim.o.relativenumber = true       -- Enable relative line numbers
vim.o.tabstop = 4                 -- Number of spaces tabs count for
vim.o.shiftwidth = 4              -- Number of spaces for indentation
vim.o.expandtab = true            -- Use spaces instead of tabs
vim.o.wrap = false                -- Disable line wrapping
vim.o.scrolloff = 8               -- Keep 8 lines visible when scrolling
vim.o.termguicolors = true        -- Enable 24-bit RGB colors
vim.o.background = 'dark'         -- Use dark background

-- Snippets path
vim.opt.runtimepath:append("~/.config/nvim/lua/snippets")

-- Transparency functions
_G.transparent_enabled = true

_G.enable_transparency = function()
    vim.cmd("colorscheme tokyonight")
    _G.transparent_enabled = true
    print("Transparency enabled")
end

_G.disable_transparency = function()
    vim.cmd("highlight Normal guibg=#1a1b26")
    vim.cmd("highlight NormalNC guibg=#1a1b26")
    vim.cmd("highlight LineNr guibg=#1a1b26")
    vim.cmd("highlight SignColumn guibg=#1a1b26")
    vim.cmd("highlight StatusLine guibg=#1a1b26")
    vim.cmd("highlight VertSplit guibg=#1a1b26")
    _G.transparent_enabled = false
    print("Transparency disabled")
end

_G.toggle_transparency = function()
    if _G.transparent_enabled then
        disable_transparency()
    else
        enable_transparency()
    end
end 