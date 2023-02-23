vim.g.mapleader = ','

local user_modules = {
  'mthadley.options',
  'mthadley.lspconfig',
  'mthadley.gitsigns',
  'mthadley.neoformat',
  'mthadley.fugitive',
  'mthadley.mappings',
  'mthadley.cursorline',
  'mthadley.filetype_quirks',
  'mthadley.colors',
  'mthadley.fzf',
  'mthadley.vim_test',
  'mthadley.vim_sort_motion',
  'mthadley.netrw',
  'mthadley.comment',
  'mthadley.autopairs',
  'mthadley.registers',
}

for _, module_path in ipairs(user_modules) do
  local success, err = pcall(require, module_path)

  if not success then
    print('Error while loading user module "' .. module_path .. '"')
    print(err)
  end
end
