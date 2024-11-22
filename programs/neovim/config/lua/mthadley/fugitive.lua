local map = vim.keymap.set
local prefix = "<C-G>"

map("n", prefix .. "s", vim.cmd.Git)
map("n", prefix .. "l", vim.cmd.Gclog)
map("n", prefix .. "b", function()
	vim.cmd.Git("blame")
end)
map("n", prefix .. "e", vim.cmd.Gedit)

map("n", prefix .. "h", vim.cmd.GBrowse)
map("v", prefix .. "h", ":GBrowse<CR>")
