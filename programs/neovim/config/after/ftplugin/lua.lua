local buf_path = vim.api.nvim_buf_get_name(0)

-- Fuzzily assume we are editing some `.lua` files related
-- to Neovim and enable the builtin completion.
if buf_path:match("neovim") then
	vim.opt_local.omnifunc = "v:lua.vim.lua_omnifunc"
end
