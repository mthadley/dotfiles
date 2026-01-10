vim.lsp.config("denols", {
	-- Not all TypeScript projects use `deno`...
	root_markers = { "deno.json", "deno.jsonc" },
})
vim.lsp.config("ts_ls", {
	-- Override default and only start the server if a `tsconfig.json`
	-- is found.
	root_markers = { "tsconfig.json" },

	-- Override default and only start if a root directory with a
	-- `tsconfig.json` is found.
	single_file_support = false,

	init_options = {
		-- Fixes double dot insertion when auto-completing with the omnifunc.
		-- https://github.com/typescript-language-server/typescript-language-server/issues/711
		completionDisableFilterText = true,
	},
})

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
