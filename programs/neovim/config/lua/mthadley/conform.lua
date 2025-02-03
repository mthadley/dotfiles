require("conform").setup {
	formatters_by_ft = {
		css = { "prettier" },
		fish = { "fish_indent" },
		go = { "goimports", "gofmt" },
		graphql = { "prettier" },
		javascript = { "prettier" },
		json = { "prettier", "deno_fmt" },
		jsonc = { "prettier", "deno_fmt" },
		lua = { "stylua" },
		markdown = { "prettier" },
		mdx = { "prettier" },
		nix = { "nixpkgs_fmt" },
		typescript = { "prettier" },
		typescriptreact = { "prettier" },
		yaml = { "prettier" },
		zig = { "zigfmt" },
	},
	format_on_save = {
		lsp_fallback = true,
		timeout_ms = 5000,
	},
	notify_on_error = false,
}
