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

		-- Direnv configruation files are the current shell.
		[".envrc"] = "fish",
	},
	pattern = {
		-- Recognize go templates
		["*.go.tmpl"] = "gohtmltmpl",
	},
})
