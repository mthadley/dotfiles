local lspconfig = require "lspconfig"
local util = require "lspconfig.util"

lspconfig.tsserver.setup {
	-- Override default and only start the server if a `tsconfig.json`
	-- is found.
	root_dir = util.root_pattern("tsconfig.json"),

	-- Override default and only start if a root directory with a
	-- `tsconfig.json` is found.
	single_file_support = false,
}
lspconfig.zls.setup {}

vim.api.nvim_create_autocmd("LspAttach", {
	group = vim.api.nvim_create_augroup("mthadley:lspconfig", {}),
	callback = function(event)
		vim.bo[event.buf].omnifunc = "v:lua.vim.lsp.omnifunc"

		for keys, fn in pairs({
			["<C-]>"] = vim.lsp.buf.definition,
			["<C-k>"] = vim.lsp.buf.signature_help,
			["<leader>ca"] = vim.lsp.buf.code_action,
			["<leader>D"] = vim.lsp.buf.type_definition,
			["<leader>e"] = vim.diagnostic.open_float,
			["<leader>f"] = vim.lsp.buf.formatting,
			["<leader>rn"] = vim.lsp.buf.rename,
			["[d"] = vim.diagnostic.goto_prev,
			["]d"] = vim.diagnostic.goto_next,
			["gD"] = vim.lsp.buf.declaration,
			["gd"] = vim.lsp.buf.definition,
			["gi"] = vim.lsp.buf.implementation,
			["gr"] = vim.lsp.buf.references,
			["K"] = vim.lsp.buf.hover,
		}) do
			vim.keymap.set("n", keys, fn, { buffer = event.buf })
		end

		local client = vim.lsp.get_client_by_id(event.data.client_id)

		-- Disabling sicne this causes a lot of syntax flashing, and I also
		-- find the "enhanced" highlighting to be too noisy.
		client.server_capabilities.semanticTokensProvider = nil
	end,
})
