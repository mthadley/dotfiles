vim.lsp.enable({
	"denols",
	"ts_ls",
	"zls",
})

vim.api.nvim_create_autocmd("LspAttach", {
	group = vim.api.nvim_create_augroup("mthadley:lspconfig", {}),
	callback = function(event)
		for keys, fn in pairs({
			["<leader>ca"] = vim.lsp.buf.code_action,
			["<leader>D"] = vim.lsp.buf.type_definition,
			["gD"] = vim.lsp.buf.declaration,
			["gd"] = vim.lsp.buf.definition,
		}) do
			vim.keymap.set("n", keys, fn, { buffer = event.buf })
		end

		local client = vim.lsp.get_client_by_id(event.data.client_id)

		-- Disabling sicne this causes a lot of syntax flashing, and I also
		-- find the "enhanced" highlighting to be too noisy.
		client.server_capabilities.semanticTokensProvider = nil
	end,
})

vim.diagnostic.config({ virtual_text = true })
