-- vim-test/vim-test
vim.g["test#strategy"] = "tslime"
vim.g["test#javascript#jest#options"] = "--watch"

if #vim.fs.find("rush.json", { upward = true }) > 0 then
	vim.g["test#javascript#jest#executable"] = "rushx test"
end

local function with_project_root(command)
	return function()
		local root = vim.fs.root(0, { "package.json", ".git" })
		if root then
			vim.g["test#project_root"] = root
		end

		vim.cmd(command)
	end
end

vim.keymap.set("n", "tt", with_project_root("TestFile"))
vim.keymap.set("n", "tn", with_project_root("TestNearest"))
vim.keymap.set("n", "ta", with_project_root("TestSuite"))

-- jgdavey/tslime.vim
vim.g.tslime_always_current_session = true
vim.g.tslime_always_current_window = true
