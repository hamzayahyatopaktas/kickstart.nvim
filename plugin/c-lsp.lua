
-- C: clangd (tamamlama, hover, tanıma git, hata gösterimi)
-- gd ve K kısayolları python-lsp.lua içindeki LspAttach ayarından gelir.
local has_blink, blink = pcall(require, 'blink.cmp')
local capabilities = has_blink and blink.get_lsp_capabilities() or nil

vim.lsp.config('clangd', {
  -- --header-insertion=never: tamamlama seçilince otomatik #include eklemesin
  cmd = { 'clangd', '--background-index', '--header-insertion=never' },
  filetypes = { 'c', 'cpp' },
  root_markers = { 'compile_commands.json', 'compile_flags.txt', '.clangd', 'Makefile', '.git' },
  capabilities = capabilities,
})

vim.lsp.enable('clangd')
