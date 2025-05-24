local lspconfig = require "lspconfig"
local util = require "lspconfig.util"

lspconfig.ts_ls.setup {
	-- Override default and only start the server if a `tsconfig.json`
	-- is found.
	root_dir = util.root_pattern("tsconfig.json"),

	-- Override default and only start if a root directory with a
	-- `tsconfig.json` is found.
	single_file_support = false,

	init_options = {
		-- Fixes double dot insertion when auto-completing with the omnifunc.
		-- https://github.com/typescript-language-server/typescript-language-server/issues/711
		completionDisableFilterText = true,
	},
}

lspconfig.denols.setup {
	-- Not all TypeScript projects use `deno`...
	root_dir = util.root_pattern("deno.json", "deno.jsonc"),
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
			["<leader>rn"] = vim.lsp.buf.rename,
			["gD"] = vim.lsp.buf.declaration,
			["gd"] = vim.lsp.buf.definition,
			["gi"] = vim.lsp.buf.implementation,
			["gr"] = vim.lsp.buf.references,
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
