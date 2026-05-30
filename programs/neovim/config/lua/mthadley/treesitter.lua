-- TODO: Why is this needed? I get compilation errors when using the plugin
-- default of `clang`.
require("nvim-treesitter.install").compilers = { "gcc" }

require("nvim-treesitter").install {
	-- These are recommended to always be installed, since they
	-- relate to general usage of Neovim.
	"c",
	"lua",
	"query",
	"vim",
	"vimdoc",

	-- Languages I often work with.
	"bash",
	"css",
	"diff",
	"embedded_template",
	"fish",
	"gitcommit",
	"gitignore",
	"html",
	"javascript",
	"json",
	"markdown",
	"markdown_inline",
	"nix",
	"ruby",
	"sql",
	"typescript",
	"yaml",
}

vim.api.nvim_create_autocmd("FileType", {
	group = vim.api.nvim_create_augroup("mthadley:treesitter", { clear = true }),
	callback = function(args)
		local lang = vim.treesitter.language.get_lang(args.match)
		if not lang then
			return
		end

		if not vim.treesitter.language.add(lang) then
			local available = require("nvim-treesitter").get_available(
				2 -- Tier 2: "unstable"
			)
			if not vim.tbl_contains(available, lang) then
				return
			end

			vim.notify("Attempting to install Treesitter grammar: " .. lang)
			require("nvim-treesitter").install(lang):wait(30000)
		end

		if vim.treesitter.query.get(lang, "highlights") then
			vim.treesitter.start(args.buf)
		end

		if vim.treesitter.query.get(lang, "indents") then
			vim.opt_local.indentexpr = 'v:lua.require("nvim-treesitter").indentexpr()'
		end
	end,
})
