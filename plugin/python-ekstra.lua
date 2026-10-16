
-- gdb tarzı ek özellikler: değerleri kodun yanında göster, ifade değerlendir, koşullu breakpoint
vim.pack.add({
  'https://github.com/mfussenegger/nvim-dap',
  'https://github.com/theHamsta/nvim-dap-virtual-text',
})

require('nvim-dap-virtual-text').setup()

local dap = require('dap')
vim.keymap.set({ 'n', 'v' }, '<leader>de', function() require('dapui').eval() end,
  { desc = 'Debug: imlecin altındaki ifadeyi değerlendir (print gibi)' })
vim.keymap.set('n', '<leader>dB', function() dap.set_breakpoint(vim.fn.input('Breakpoint koşulu: ')) end,
  { desc = 'Debug: koşullu breakpoint (break if)' })
vim.keymap.set('n', '<leader>dr', dap.run_to_cursor,
  { desc = 'Debug: imlece kadar çalıştır' })
