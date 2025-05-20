-- Bootstrap Packer
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
          style = "night",
          transparent = true,
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
          ensure_installed = { "lua", "python", "javascript", "html", "css", "go" },
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
  use { 'windwp/nvim-autopairs', requires = { 'hrsh7th/nvim-cmp' }, config = function()
      require('nvim-autopairs').setup({
          check_ts = true,
          ts_config = {
              lua = {'string'},
              javascript = {'template_string'},
          },
          fast_wrap = {
              map = '<M-e>',
              chars = { '{', '[', '(', '"', "'" },
              pattern = [=[[%'%"%>%]%)%}%,]]=],
              end_key = '$',
              keys = 'qwertyuiopzxcvbnmasdfghjkl',
              check_comma = true,
              highlight = 'Search',
              highlight_grey='Comment'
          },
      })
  end }
  use { 'hrsh7th/vim-vsnip' }

  -- Discord Presence
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
    end
  }

  -- LSP and Debugging
  use 'neovim/nvim-lspconfig'
  use { 'williamboman/mason.nvim', config = function()
      require('mason').setup({
          ui = {
              check_outdated_packages_on_open = false,
              border = "rounded",
              icons = {
                  package_installed = "✓",
                  package_pending = "➜",
                  package_uninstalled = "✗"
              }
          }
      })
  end }
  use { 'williamboman/mason-lspconfig.nvim', requires = {'williamboman/mason.nvim'}, config = function()
      require('mason-lspconfig').setup({
          ensure_installed = { "lua_ls", "gopls", "pyright" },
          automatic_installation = true,
      })
  end }
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

  -- Which-key for keybinding preview
  use { 'folke/which-key.nvim', config = function()
      require('which-key').setup()
  end }

  -- Codeium AI assistant (alternative to GitHub Copilot)
  use {
    'Exafunction/codeium.vim',
    config = function()
      -- No special setup needed for basic functionality
      vim.g.codeium_disable_bindings = 1
      vim.keymap.set('i', '<C-g>', function() return vim.fn['codeium#Accept']() end, { expr = true })
      vim.keymap.set('i', '<C-;>', function() return vim.fn['codeium#CycleCompletions'](1) end, { expr = true })
      vim.keymap.set('i', '<C-,>', function() return vim.fn['codeium#CycleCompletions'](-1) end, { expr = true })
      vim.keymap.set('i', '<C-x>', function() return vim.fn['codeium#Clear']() end, { expr = true })
    end
  }

  -- Formatter
  use { 'mhartington/formatter.nvim', config = function()
      require('formatter').setup({
          filetype = {
              lua = {
                  function()
                      return {
                          exe = "stylua",
                          args = {"-"},
                          stdin = true
                      }
                  end
              },
              python = {
                  function()
                      return {
                          exe = "black",
                          args = {"-"},
                          stdin = true
                      }
                  end
              },
              javascript = {
                  function()
                      return {
                          exe = "prettier",
                          args = {"--stdin-filepath", vim.api.nvim_buf_get_name(0)},
                          stdin = true
                      }
                  end
              }
          }
      })
  end }

  -- Automatically sync Packer if bootstrapped
  if packer_bootstrap then
    require('packer').sync()
  end
end) 