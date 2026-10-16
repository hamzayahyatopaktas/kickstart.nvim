
-- C debug: gdb (14 veya üstü) yerleşik DAP desteğiyle nvim-dap'a bağlanır
vim.pack.add({ 'https://github.com/mfussenegger/nvim-dap' })
local dap = require('dap')

dap.adapters.gdb = {
  type = 'executable',
  command = 'gdb',
  args = { '--quiet', '--interpreter=dap', '--eval-command', 'set print pretty on' },
}

local function program_sor()
  local yol = vim.fn.input('Çalıştırılabilir dosya: ', vim.fn.getcwd() .. '/', 'file')
  return (yol ~= '') and yol or dap.ABORT
end

dap.configurations.c = {
  {
    name = 'Çalıştır (gdb)',
    type = 'gdb',
    request = 'launch',
    program = program_sor,
    cwd = '${workspaceFolder}',
    stopAtBeginningOfMainSubprogram = false,
  },
  {
    name = 'Argümanlarla çalıştır (gdb)',
    type = 'gdb',
    request = 'launch',
    program = program_sor,
    args = function()
      return vim.split(vim.fn.input('Argümanlar: '), ' ', { trimempty = true })
    end,
    cwd = '${workspaceFolder}',
    stopAtBeginningOfMainSubprogram = false,
  },
}
