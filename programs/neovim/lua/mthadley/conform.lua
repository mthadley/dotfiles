require("conform").setup({
	formatters_by_ft = {
		fish = { "fish_indent" },
		go = { "goimports", "gofmt" },
		javascript = { "prettier" },
		lua = { "stylua" },
		mdx = { "prettier" },
		nix = { "nixpkgs_fmt" },
		typescript = { "prettier" },
		zig = { "zigfmt" },
	},
	format_on_save = {
		lsp_fallback = true,
		timeout_ms = 500,
	},
	notify_on_error = false,
})
