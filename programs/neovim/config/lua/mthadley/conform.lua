require("conform").setup {
	formatters_by_ft = {
		css = { "prettier" },
		fish = { "fish_indent" },
		go = { "goimports", "gofmt" },
		javascript = { "prettier" },
		json = { "prettier" },
		jsonc = { "prettier" },
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
		timeout_ms = 1000,
	},
	notify_on_error = false,
}
