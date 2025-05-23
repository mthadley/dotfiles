local set = vim.opt

set.backup = false
set.clipboard = "unnamedplus"
set.completeopt:remove { "preview" }
set.expandtab = true
set.grepprg = RIPGREP_PATH .. " --vimgrep"
set.ignorecase = true
set.mouse = "a"
set.number = true
set.relativenumber = true
set.scrolloff = 10
set.shiftround = true
set.shiftwidth = 2
set.tabstop = 2
set.splitbelow = true
set.splitright = true
set.undofile = true
set.updatetime = 100
set.writebackup = false
set.guicursor = "" -- Restore plain white cursor that I'm used to

local group = vim.api.nvim_create_augroup("mthadley:options", {})

set.autoread = true
vim.api.nvim_create_autocmd("CursorHold", {
	callback = function(event)
		if vim.api.nvim_buf_get_option(event.buf, "buftype") ~= "nofile" then
			vim.cmd "checktime"
		end
	end,
	desc = "Autoreload files on change",
	group = group,
})

vim.api.nvim_create_autocmd("BufWritePre", {
	callback = function()
		local previous_search_register = vim.fn.getreg("/")
		vim.cmd "silent! %s/\\s\\+$//e"
		vim.fn.setreg("/", previous_search_register)
	end,
	desc = "Remove trailing whitespace",
	group = group,
})
