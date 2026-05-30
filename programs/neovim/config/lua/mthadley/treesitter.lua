-- TODO: Why is this needed? I get compilation errors when using the plugin
-- default of `clang`.
require("nvim-treesitter.install").compilers = { "gcc" }

require("nvim-treesitter").install {
	-- These are reccomended to always be installed, since they
	-- relate to general usage of Neovim.
	"c",
	"lua",
	"query",
	"vim",
	"vimdoc",

	-- Languages I often work with.
	"bash",
	"embedded_template",
	"fish",
	"html",
	"javascript",
	"json",
	"markdown",
	"markdown_inline",
	"nix",
	"ruby",
	"typescript",
	"yaml",
}

vim.api.nvim_create_autocmd("FileType", {
	group = vim.api.nvim_create_augroup("mthadley:treesitter", { clear = true }),
	callback = function(args)
		local lang = vim.treesitter.language.get_lang(args.match)
		if not lang or not vim.treesitter.language.add(lang) then
			return
		end

		if vim.treesitter.query.get(lang, "highlights") then
			vim.treesitter.start(args.buf)
		end

		if vim.treesitter.query.get(lang, "indents") then
			vim.opt_local.indentexpr = 'v:lua.require("nvim-treesitter").indentexpr()'
		end
	end,
})
