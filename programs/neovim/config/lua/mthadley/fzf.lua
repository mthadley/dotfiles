local fzf = require("fzf-lua")

fzf.setup {
	winopts = {
		backdrop = 100,
		height = 0.4,
		row = 1,
		width = 1,

		preview = {
			horizontal = "right:50%",
			layout = "horizontal",
			winopts = {
				cursorline = false,
			},
		},
	},

	fzf_opts = {
		-- Defaults to `'reverse'`, which puts the prompt at the
		-- top, but setting thise `false` removes the flag and displays
		-- it at the bottom.
		["--layout"] = false,
	},
}

vim.keymap.set("n", "<C-T>", vim.cmd.FzfLua)
vim.keymap.set("n", "<C-P>", function()
	fzf.files({
		cmd = FD_PATH
			.. " --color=never --hidden --type f --type l --exclude .git | "
			.. ZIMILAR_ZORT_PATH
			.. ' "'
			.. vim.api.nvim_eval('expand("%")')
			.. '"',
		fzf_opts = {
			["--scheme"] = "history",
		},
		actions = {
			-- Disable the default "git ignore" toggle action
			["ctrl-g"] = false,
		},
	})
end, { silent = true })

fzf.register_ui_select()
