-- pangloss/vim-javascript
vim.g.jsx_ext_required = false
vim.g.javascript_plugin_jsdoc = true

-- plasticboy/vim-markdown
vim.g.vim_markdown_folding_disabled = true
vim.g.vim_markdown_fenced_languages = { "js=javascript", "ini=dosini" }

local group = vim.api.nvim_create_augroup("mthadley:filetype-quirks", { clear = true })

vim.filetype.add({
	extension = {
		-- Treat MDX files as markdown until there's a first-class Treesitter
		-- parser.
		mdx = "markdown",
	},
	filename = {
		-- JSON configuration files that can contain comments
		["rush.json"] = "jsonc",

		-- Treat Prettier ignore files as a .gitignore
		[".prettierignore"] = "gitignore",
	},
	pattern = {
		-- Recognize go templates
		["*.go.tmpl"] = "gohtmltmpl",
	},
})

vim.api.nvim_create_autocmd("FileType", {
	callback = function()
		vim.opt_local.spell = true
		vim.opt_local.textwidth = 80
	end,
	desc = "Wrap lines when writing Markdown",
	pattern = "markdown",
	group = group,
})
