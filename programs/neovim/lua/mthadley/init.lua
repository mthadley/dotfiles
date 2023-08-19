vim.g.mapleader = ','

local user_config_dir =
  vim.fs.dirname(vim.env.MYVIMRC) .. '/lua/mthadley'

for file in vim.fs.dir(user_config_dir) do
  if file ~= 'init.lua' then
    local module_path = 'mthadley' .. '.' .. vim.fn.fnamemodify(file, ':r')
    local success, err = pcall(require, module_path)

    if not success then
      print('Error while loading user module "' .. module_path .. '"')
      print(err)
    end
  end
end
