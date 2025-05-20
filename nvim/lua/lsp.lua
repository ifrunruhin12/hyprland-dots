-- Enable Mason
require("mason").setup()
require("mason-lspconfig").setup()

-- Set up LSP for Go using gopls
local lspconfig = require('lspconfig')

lspconfig.gopls.setup {
    on_attach = function(client, bufnr)
        -- Keybindings for LSP functionality
        local opts = { noremap = true, silent = true }
        local buf_set_keymap = vim.api.nvim_buf_set_keymap

        buf_set_keymap(bufnr, 'n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
        buf_set_keymap(bufnr, 'n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
        buf_set_keymap(bufnr, 'n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
        buf_set_keymap(bufnr, 'n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
        buf_set_keymap(bufnr, 'n', '<leader>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
    end,

    -- Capabilities for autocompletion
    capabilities = require('cmp_nvim_lsp').default_capabilities(),
}

-- Set up LSP for Python using pyright
lspconfig.pyright.setup {
    on_attach = function(client, bufnr)
        -- Keybindings for Python LSP functionality
        local opts = { noremap = true, silent = true }
        local buf_set_keymap = vim.api.nvim_buf_set_keymap

        buf_set_keymap(bufnr, 'n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
        buf_set_keymap(bufnr, 'n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
        buf_set_keymap(bufnr, 'n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
        buf_set_keymap(bufnr, 'n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
        buf_set_keymap(bufnr, 'n', '<leader>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
    end,

    -- Capabilities for autocompletion
    capabilities = require('cmp_nvim_lsp').default_capabilities(),
} 