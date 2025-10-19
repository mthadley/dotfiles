-- The default intall path is somewhere under `/nix` which
-- is not writable, we need to install parsers somewhere else.
local parser_install_dir = vim.fn.expand("~/.local/share/nvim/treesitter/parsers")

-- The custom install path needs to also be added to the "rtp". Uses
-- `prepend` instead of `append` so that we don't use the bundled
-- parsers which seem to be out of date and throw errors.
vim.opt.runtimepath:prepend(parser_install_dir)

-- TODO: Why is this needed? I get compilation errors when using the plugin
-- default of `clang`.
require("nvim-treesitter.install").compilers = { "gcc" }

require("nvim-treesitter.configs").setup {
	parser_install_dir = parser_install_dir,

	ensure_installed = {
		-- These are reccomended to always be installed, since they
		-- relate to general usage of Neovim.
		"c",
		"lua",
		"query",
		"vim",
		"vimdoc",

		-- Languages I often work with.
		"bash",
		"fish",
		"javascript",
		"json",
		"markdown",
		"markdown_inline",
		"nix",
		"ruby",
		"typescript",
		"yaml",
	},

	auto_install = true,

	highlight = {
		enable = true,
	},

	indent = {
		enable = true,
		disable = {
			-- The indentation is weird on Ruby right now, so falling
			-- back to the non-treesitter default, but maybe can be removed
			-- in the future.
			"ruby",
		},
	},
}
