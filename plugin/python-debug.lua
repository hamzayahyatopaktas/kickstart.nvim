
-- Debugger: nvim-dap + arayüz (nvim-dap-ui) + Python köprüsü (nvim-dap-python)
vim.pack.add({
  'https://github.com/mfussenegger/nvim-dap',
  'https://github.com/nvim-neotest/nvim-nio',
  'https://github.com/rcarriga/nvim-dap-ui',
  'https://github.com/mfussenegger/nvim-dap-python',
})

local dap = require('dap')
local dapui = require('dapui')
dapui.setup()

-- Debug başlayınca arayüz kendiliğinden açılsın (kapatmak için <leader>du)
dap.listeners.before.attach.dapui_config = function() dapui.open() end
dap.listeners.before.launch.dapui_config = function() dapui.open() end

require('dap-python').setup(vim.fn.expand('~/.virtualenvs/debugpy/bin/python'))

vim.fn.sign_define('DapBreakpoint', { text = '●', texthl = 'DiagnosticError' })
vim.fn.sign_define('DapStopped', { text = '▶', texthl = 'DiagnosticWarn', linehl = 'Visual' })

-- F11 terminalde tam ekran yaptığı için F tuşları yerine <leader> kullanıyoruz
local function map(lhs, rhs, desc)
  vim.keymap.set('n', lhs, rhs, { desc = 'Debug: ' .. desc })
end
map('<leader>db', dap.toggle_breakpoint, 'Breakpoint koy/kaldır')
map('<leader>dc', dap.continue, 'Başlat / devam et')
map('<leader>dn', dap.step_over, 'Sonraki satır (step over)')
map('<leader>di', dap.step_into, 'İçine gir (step into)')
map('<leader>do', dap.step_out, 'Dışına çık (step out)')
map('<leader>dq', dap.terminate, 'Durdur')
map('<leader>du', dapui.toggle, 'Arayüzü aç/kapat')
