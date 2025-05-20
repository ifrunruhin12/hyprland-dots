-- Telescope keymaps
vim.api.nvim_set_keymap('n', '<leader>ff', ':Telescope find_files<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>tlg', ':Telescope live_grep<CR>', { noremap = true, silent = true })

-- Terminal and file explorer
vim.api.nvim_set_keymap('n', '<leader>t', ':ToggleTerm<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>e', ':NvimTreeToggle<CR>', { noremap = true, silent = true })

-- Buffer management
vim.api.nvim_set_keymap('n', '<leader>bd', ':bdelete<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>bb', ':BufferLineCycleNext<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>bp', ':BufferLineCyclePrev<CR>', { noremap = true, silent = true })

-- Git
vim.keymap.set("n", "<leader>lg", ":LazyGit<CR>", { silent = true })

-- Code execution with filetype detection
_G.RunCurrentFile = function()
  local ft = vim.bo.filetype
  if ft == "cpp" then
    vim.cmd('!g++ -o %:r % && ./%:r')
  elseif ft == "go" then
    vim.cmd('!go run %')
  elseif ft == "python" then
    vim.cmd('!python3 %')
  elseif ft == "javascript" or ft == "typescript" then
    vim.cmd('!node %')
  elseif ft == "lua" then
    vim.cmd('!lua %')
  elseif ft == "sh" or ft == "bash" then
    vim.cmd('!bash %')
  else
    print("No run command for filetype: " .. ft)
  end
end

vim.api.nvim_set_keymap('n', '<leader>r', ':w<CR>:lua RunCurrentFile()<CR>', { noremap = true, silent = true })

-- Formatting
vim.api.nvim_set_keymap('n', '<leader>f', ':Format<CR>', { noremap = true, silent = true })

-- Transparency toggle
vim.api.nvim_set_keymap('n', '<leader>tt', ':lua toggle_transparency()<CR>', { noremap = true, silent = true }) 