
-- Test çalıştırıcı: neotest + pytest
vim.pack.add({
  'https://github.com/nvim-lua/plenary.nvim',
  'https://github.com/nvim-neotest/nvim-nio',
  'https://github.com/nvim-neotest/neotest',
  'https://github.com/nvim-neotest/neotest-python',
})

require('neotest').setup({
  adapters = {
    require('neotest-python')({ runner = 'pytest', dap = { justMyCode = false } }),
  },
  icons = {
    passed = '✓', failed = '✗', running = '…', skipped = '–', unknown = '?',
    expanded = '▾', collapsed = '▸',
  },
})

local function map(lhs, rhs, desc)
  vim.keymap.set('n', lhs, rhs, { desc = 'Test: ' .. desc })
end
map('<leader>tt', function() require('neotest').run.run() end, 'İmlecin altındaki test')
map('<leader>tf', function() require('neotest').run.run(vim.fn.expand('%')) end, 'Bu dosyadaki testler')
map('<leader>tl', function() require('neotest').run.run_last() end, 'Son testi tekrarla')
map('<leader>ts', function() require('neotest').summary.toggle() end, 'Özet paneli')
map('<leader>to', function() require('neotest').output.open({ enter = true }) end, 'Çıktıyı göster')
map('<leader>td', function() require('neotest').run.run({ strategy = 'dap' }) end, 'Testi debug ile çalıştır')
