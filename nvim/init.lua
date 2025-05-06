-- Bootstrap Packer (ensure it's installed)
local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
  if fn.empty(fn.glob(install_path)) > 0 then
    print("Installing packer.nvim...")
    fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
    vim.cmd [[packadd packer.nvim]]
    return true
  end
  return false
end

local packer_bootstrap = ensure_packer()

-- Load and configure Packer
vim.cmd [[packadd packer.nvim]]

require('packer').startup(function(use)
  -- Packer manages itself
  use 'wbthomason/packer.nvim'


  -- Aesthetic Plugins
  use { 'folke/tokyonight.nvim', config = function()
      require('tokyonight').setup {
          style = "night", -- Options: storm, night, day
          transparent = true, -- Enable transparency
      }
      vim.cmd[[colorscheme tokyonight]]
  end }
  use { 'nvim-lualine/lualine.nvim', requires = { 'nvim-tree/nvim-web-devicons', opt = true }, config = function()
      require('lualine').setup { options = { theme = 'tokyonight' } }
  end }
  use { 'akinsho/bufferline.nvim', requires = 'nvim-tree/nvim-web-devicons', config = function()
      require('bufferline').setup {}
  end }
  use { 'goolord/alpha-nvim', config = function()
      require('alpha').setup(require('alpha.themes.startify').config)
  end }
  use 'nvim-tree/nvim-web-devicons'

  -- Functional Plugins
  use { 'nvim-tree/nvim-tree.lua', requires = 'nvim-tree/nvim-web-devicons', config = function()
      require('nvim-tree').setup {}
  end }
  use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate', config = function()
      require('nvim-treesitter.configs').setup {
          ensure_installed = { "lua", "python", "javascript", "html", "css", "go" }, -- Add Go here
          highlight = { enable = true },
      }
  end }
  use { 'nvim-telescope/telescope.nvim', requires = { 'nvim-lua/plenary.nvim' }, config = function()
      require('telescope').setup {}
  end }
  use { 'akinsho/toggleterm.nvim', config = function()
      require('toggleterm').setup {}
  end }
  use { 'ray-x/go.nvim', requires = { 'ray-x/guihua.lua' }, config = function()
      require('go').setup()
  end }

  -- Snippet and Autocompletion
  use { 'L3MON4D3/LuaSnip', config = function()
      require('luasnip.loaders.from_vscode').lazy_load()
  end }
  use { 'hrsh7th/nvim-cmp', requires = { 'hrsh7th/cmp-nvim-lsp', 'hrsh7th/cmp-buffer', 'hrsh7th/cmp-path', 'hrsh7th/cmp-cmdline' } }

  use { 'hrsh7th/vim-vsnip' } -- add this line


  use {
    "andweeb/presence.nvim",
    config = function()
        require("presence").setup({
            auto_update        = true,
            neovim_image_text  = "Coding like a boss in Neovim",
            main_image         = "neovim",
            log_level          = nil,
            debounce_timeout   = 10,
            enable_line_number = true,
            buttons            = true,
        })
    end }


  -- LSP and Debugging
  use 'neovim/nvim-lspconfig'
  use 'williamboman/mason.nvim'
  use 'williamboman/mason-lspconfig.nvim'
  use { 'mfussenegger/nvim-dap' }
  use { 'leoluz/nvim-dap-go', requires = 'mfussenegger/nvim-dap', config = function()
      require('dap-go').setup()
  end }

  -- Code Formatting
  use { 'nvimtools/none-ls.nvim', requires = { 'nvim-lua/plenary.nvim' }, config = function()
      local null_ls = require('null-ls')
      null_ls.setup {
          sources = {
              null_ls.builtins.formatting.prettier,
              null_ls.builtins.formatting.black,
          }
	}
  end }

  use {
      'kdheepak/lazygit.nvim',
	  requires = { 'nvim-lua/plenary.nvim' }
  }

  -- Smooth Scrolling
  use { 'karb94/neoscroll.nvim', config = function()
      require('neoscroll').setup()
  end }

  -- Automatically sync Packer if bootstrapped
  if packer_bootstrap then
    require('packer').sync()
  end
end)

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

-- Keybindings
vim.api.nvim_set_keymap('n', '<leader>ff', ':Telescope find_files<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>tlg', ':Telescope live_grep<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>t', ':ToggleTerm<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>e', ':NvimTreeToggle<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>bd', ':bdelete<CR>', { noremap = true, silent = true })

vim.api.nvim_set_keymap('n', '<leader>bb', ':BufferLineCycleNext<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>bp', ':BufferLineCyclePrev<CR>', { noremap = true, silent = true })

-- Custom Keybindings
vim.keymap.set("n", "<leader>lg", ":LazyGit<CR>", { silent = true })

-- Bufferline keybindings
vim.api.nvim_set_keymap('n', '<leader>bb', ':BufferLineCycleNext<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>bp', ':BufferLineCyclePrev<CR>', { noremap = true, silent = true })

-- Shortcut to run C++ code
vim.api.nvim_set_keymap('n', '<leader>r', ':!g++ -o %:r % && ./%:r<CR>', { noremap = true, silent = true })

-- Shortcut to run Go code
vim.api.nvim_set_keymap('n', '<leader>r', ':w<CR>:!go run %<CR>', { noremap = true, silent = true })


vim.opt.runtimepath:append("~/.config/nvim/lua/snippets")

-- LSP and Autocompletion Configuration
require("luasnip").setup({})
require("luasnip.loaders.from_lua").load({ paths = "~/.config/nvim/lua/snippets/" })
-- Enable Mason (optional) for easy LSP management
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
local lspconfig = require('lspconfig')

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


-- Autocompletion Configuration
local cmp = require'cmp'

cmp.setup {
    snippet = {
        expand = function(args)
            require('luasnip').lsp_expand(args.body)
        end,
    },
    mapping = cmp.mapping.preset.insert({
        ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept suggestion with Enter
        ['<C-y>'] = cmp.mapping.confirm({ select = true }), --Keep Ctrl+y as an alternative
        ['<C-Space>'] = cmp.mapping.complete(), -- Trigger completion
    }),
    sources = cmp.config.sources({
        { name = 'nvim_lsp' },
        { name = 'luasnip' },
    })
}

vim.api.nvim_set_keymap("i", "<Tab>", "v:lua.require'luasnip'.expand_or_jumpable() ? '<Plug>luasnip-expand-or-jump' : '<Tab>'", {expr = true, silent = true})
vim.api.nvim_set_keymap("s", "<Tab>", "<cmd>lua require'luasnip'.jump(1)<Cr>", {silent = true})
vim.api.nvim_set_keymap("s", "<S-Tab>", "<cmd>lua require'luasnip'.jump(-1)<Cr>", {silent = true})




-- Declare the transparency state variable globally
_G.transparent_enabled = true

-- Function to enable transparency
_G.enable_transparency = function()
    vim.cmd("colorscheme tokyonight") -- Reset colorscheme to apply transparency
    _G.transparent_enabled = true
    print("Transparency enabled")
end

-- Function to disable transparency
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

-- Toggle Transparency
_G.toggle_transparency = function()
    if _G.transparent_enabled then
        disable_transparency()
    else
        enable_transparency()
    end
end

-- Keybinding for transparency toggle
vim.api.nvim_set_keymap('n', '<leader>tt', ':lua toggle_transparency()<CR>', { noremap = true, silent = true })

