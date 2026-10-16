
-- Hata görünümü: ruff mesajlarını Türkçeleştir + <leader>ud ve <leader>uv ile aç/kapat

-- { 'İngilizce kalıp', 'Türkçe karşılık' }  (kalıplarda '-' işareti '%-' diye yazılır)
local ceviriler = {
  { 'Import block is un%-sorted or un%-formatted', 'Import bloğu sıralanmamış veya biçimlendirilmemiş' },
  { 'help: Organize imports', 'yardım: Importları düzenle' },
  { 'Shebang is present but file is not executable', 'Shebang var ama dosya çalıştırılabilir değil' },
  { 'The file is executable but no shebang is present', 'Dosya çalıştırılabilir ama shebang yok' },
  { 'Undefined name', 'Tanımsız isim' },
  { 'imported but unused', 'içe aktarılmış ama kullanılmıyor' },
  { 'help: Remove unused import', 'yardım: Kullanılmayan importu kaldır' },
  { 'Local variable (.-) is assigned to but never used', 'Yerel değişken %1 tanımlanmış ama hiç kullanılmamış' },
  { 'Line too long', 'Satır çok uzun' },
  { 'Trailing whitespace', 'Satır sonunda gereksiz boşluk' },
  { 'Blank line contains whitespace', 'Boş satır boşluk içeriyor' },
  { 'No newline at end of file', 'Dosya sonunda yeni satır yok' },
  { 'Module level import not at top of file', 'Modül düzeyindeki import dosyanın başında değil' },
  { 'Do not use bare `except`', 'Çıplak `except` kullanma' },
  { 'Ambiguous variable name', 'Belirsiz değişken adı' },
}

local function turkcelestir(diagnostic)
  local mesaj = diagnostic.message
  for _, c in ipairs(ceviriler) do
    mesaj = mesaj:gsub(c[1], c[2])
  end
  return mesaj
end

-- kickstart'ın mevcut ayarlarını koruyup yalnızca 'format' alanını ekle
local function birlestir(anahtar)
  local mevcut = vim.diagnostic.config()[anahtar]
  if type(mevcut) ~= 'table' then mevcut = {} end
  return vim.tbl_extend('force', mevcut, { format = turkcelestir })
end

vim.diagnostic.config({
  virtual_text = birlestir('virtual_text'),
  float = birlestir('float'),
})

-- Hataları tamamen göster/gizle (alt çizgi, yan işaret, satır sonu mesajı)
vim.keymap.set('n', '<leader>ud', function()
  local acik = not vim.diagnostic.is_enabled()
  vim.diagnostic.enable(acik)
  vim.notify('Hata görünümü: ' .. (acik and 'AÇIK' or 'KAPALI'))
end, { desc = 'Hataları göster/gizle' })

-- Sadece satır sonundaki mesajları göster/gizle (alt çizgi ve yan işaretler kalır)
local sanal_metin_ayari = vim.diagnostic.config().virtual_text
local sanal_metin_acik = true
vim.keymap.set('n', '<leader>uv', function()
  sanal_metin_acik = not sanal_metin_acik
  vim.diagnostic.config({ virtual_text = sanal_metin_acik and sanal_metin_ayari or false })
  vim.notify('Satır sonu mesajları: ' .. (sanal_metin_acik and 'AÇIK' or 'KAPALI'))
end, { desc = 'Satır sonu hata mesajlarını göster/gizle' })
