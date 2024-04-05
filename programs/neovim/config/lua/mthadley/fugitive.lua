for keys, cmd in pairs({
	["<C-G>s"] = vim.cmd.Git,
	["<C-G>l"] = vim.cmd.Gclog,
	["<C-G>b"] = function()
		vim.cmd.Git("blame")
	end,
	["<C-G>h"] = vim.cmd.GBrowse,
	["<C-G>e"] = vim.cmd.Gedit,
}) do
	vim.keymap.set("n", keys, cmd)
end

local group = vim.api.nvim_create_augroup("mthadley:fugitive", { clear = true })
