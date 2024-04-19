vim.g.mapleader = ","

local user_config_dir = vim.fs.dirname(vim.env.MYVIMRC) .. "/lua/mthadley"

for file, type in vim.fs.dir(user_config_dir) do
	-- `vim.fs.dir` currently does not resolve links, so fall
	-- back to `uv.fs_stat` which does.
	if type == "link" then
		local file_path = user_config_dir .. "/" .. file
		type = vim.loop.fs_stat(file_path).type
	end

	if type == "file" and file ~= "init.lua" then
		local module_path = "mthadley" .. "." .. vim.fn.fnamemodify(file, ":r")
		local success, err = pcall(require, module_path)

		if not success then
			print('Error while loading user module "' .. module_path .. '"')
			print(err)
		end
	end
end
