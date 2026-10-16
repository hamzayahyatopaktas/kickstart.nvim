
-- Arka planı saf siyah yapar (hangi renk şeması olursa olsun)
local function apply()
  local function set_bg(group, bg)
    local hl = vim.api.nvim_get_hl(0, { name = group, link = false })
    vim.api.nvim_set_hl(0, group, vim.tbl_extend('force', hl, { bg = bg }))
  end
  for _, group in ipairs({
    'Normal', 'NormalNC', 'NormalFloat', 'SignColumn', 'EndOfBuffer',
    'FoldColumn', 'MsgArea', 'LineNr', 'CursorLineNr', 'WinSeparator',
  }) do
    set_bg(group, '#000000')
  end
  set_bg('CursorLine', '#121212')
end

vim.api.nvim_create_autocmd('ColorScheme', { callback = apply })
apply()
