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

-- Run rush build for the package containing the current buffer
keymap.set("n", "<leader>b", function()
	local rush_root = vim.fs.find({ "rush.json" }, {
		path = vim.api.nvim_buf_get_name(0),
		upward = true,
	})[1]
	if not rush_root then
		vim.print("No rush.json found. Ostensibly not a Rush project.")
		return
	end
	local rush_root_dir = vim.fn.fnamemodify(rush_root, ":p:h")

	-- Get path of the current buffer
	local package_json = vim.fs.find({ "package.json" }, {
		path = vim.api.nvim_buf_get_name(0),
		upward = true,
		stop = rush_root,
	})[1]

	local target_options = ""
	if package_json then
		local package_dir = vim.fs.dirname(package_json)

		if package_dir == rush_root_dir then
			vim.print("No package.json found. Building the entire project.")
		else
			local package_name = vim.fs.basename(package_dir)
			target_options = " --to=" .. package_name
		end
	end

	-- Depends on `tslime` for this `Tmux` command
	vim.cmd.Tmux("rush build" .. target_options)
end, { silent = true })
