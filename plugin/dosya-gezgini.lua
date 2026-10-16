
-- Dosya gezgini (Nerd Font simgeli): <Space>e ile aç/kapat
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

vim.pack.add({
  'https://github.com/nvim-tree/nvim-web-devicons',
  'https://github.com/nvim-tree/nvim-tree.lua',
})

require('nvim-tree').setup({
  view = { width = 32 },
})

vim.keymap.set('n', '<leader>e', '<cmd>NvimTreeToggle<CR>', { desc = 'Dosya gezgini aç/kapat' })
vim.keymap.set('n', '<leader>E', '<cmd>NvimTreeFindFile<CR>', { desc = 'Açık dosyayı gezginde göster' })
