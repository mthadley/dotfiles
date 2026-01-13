return {
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

	cmd_env = {
		-- Seeing exits on larger repositories. Cranking up the ol' "old space" seems
		-- to be helpiing. Other related discussion:
		--
		--   https://github.com/LazyVim/LazyVim/discussions/5086
		--
		NODE_OPTIONS = "--max-old-space-size=8192",
	},
}
