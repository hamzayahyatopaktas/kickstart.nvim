
-- Python: basedpyright (tamamlama, hover, tanıma git, tip kontrolü) + ruff (lint)
vim.o.winborder = 'rounded'

-- kickstart'ta blink.cmp varsa onu kullan, yoksa Neovim'in yerleşik tamamlamasını aç
local has_blink, blink = pcall(require, 'blink.cmp')
local capabilities = has_blink and blink.get_lsp_capabilities() or nil
if not has_blink then
  vim.o.completeopt = 'menu,menuone,noselect,popup'
end

local root = { 'pyproject.toml', 'pyrightconfig.json', 'setup.py', 'setup.cfg', 'requirements.txt', '.git' }

vim.lsp.config('basedpyright', {
  cmd = { 'basedpyright-langserver', '--stdio' },
  filetypes = { 'python' },
  root_markers = root,
  capabilities = capabilities,
  settings = {
    basedpyright = { analysis = { typeCheckingMode = 'standard', autoImportCompletions = true } },
  },
})

vim.lsp.config('ruff', {
  cmd = { 'ruff', 'server' },
  filetypes = { 'python' },
  root_markers = root,
  capabilities = capabilities,
})

vim.lsp.enable({ 'basedpyright', 'ruff' })

vim.api.nvim_create_autocmd('LspAttach', {
  callback = function(ev)
    local client = vim.lsp.get_client_by_id(ev.data.client_id)
    if not client then return end
    -- hover bilgisi basedpyright'tan gelsin
    if client.name == 'ruff' then client.server_capabilities.hoverProvider = false end

    local function map(mode, lhs, rhs, desc)
      vim.keymap.set(mode, lhs, rhs, { buffer = ev.buf, desc = 'LSP: ' .. desc })
    end
    map('n', 'gd', vim.lsp.buf.definition, 'Tanıma git')
    map('n', 'K', vim.lsp.buf.hover, 'Dokümantasyonu göster')

    if not has_blink and client:supports_method('textDocument/completion') then
      vim.lsp.completion.enable(true, client.id, ev.buf, { autotrigger = true })
      map('i', '<C-Space>', vim.lsp.completion.get, 'Tamamlamayı aç')
    end
  end,
})
