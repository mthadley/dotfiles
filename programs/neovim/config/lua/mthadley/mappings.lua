local keymap = vim.keymap

keymap.set("i", "jk", "<ESC>")

-- Session Management
keymap.set("n", "<leader>ss", ":mks! ~/.vimsession<CR>")
keymap.set("n", "<leader>os", ":so ~/.vimsession<CR>")

-- Saving
keymap.set("n", "<leader>w", ":w<CR>")

-- Misc. Mappings
keymap.set("n", "<leader>m", ":Man<CR>")
keymap.set("n", "<leader>n", ":noh<CR>")
keymap.set("n", "<leader>q", ":q<CR>")
keymap.set("n", "<leader>rs", ":syntax sync fromstart<CR>")

-- Toggle the Quickfix window
keymap.set("n", "<leader>cw", function()
	for _, bufnr in ipairs(vim.api.nvim_list_bufs()) do
		if vim.fn.bufwinid(bufnr) ~= -1 and vim.api.nvim_buf_get_option(bufnr, "buftype") == "quickfix" then
			vim.cmd.cclose()
			return
		end
	end

	vim.cmd.copen()
end, { silent = true })
