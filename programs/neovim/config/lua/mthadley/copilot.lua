require("copilot").setup {
	suggestion = {
		auto_trigger = true,
		keymap = {
			accept = "<C-p>",
			next = "<C-[>",
			dismiss = "<C-]>",
			prev = nil,
		},
	},

	copilot_node_command = NODE_PATH,
}
