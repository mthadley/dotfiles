vim.cmd.colorscheme "base16-ocean"

local function hi(group, options)
	local ns_id = 0
	local current_options = vim.api.nvim_get_hl(ns_id, { name = group })

	-- Inherit existing options rather than clearing them out
	if not current_options.link then
		options = vim.tbl_extend("keep", options, current_options)
	end

	vim.api.nvim_set_hl(ns_id, group, options)
end

local function clear(group, ns_id)
	ns_id = ns_id or 0
	vim.api.nvim_set_hl(ns_id, group, {})
end

hi("FloatBorder", { link = "Comment" })
hi("FzfLuaBorder", { link = "FloatBorder" })

local colors = require("base16-colorscheme").colors

local gray_bg = colors.base01
local gray_fg = colors.base03
local white_fg = colors.base05
local red_fg = colors.base08
local yellow_fg = colors.base09

-- Split separators
hi("VertSplit", { fg = gray_bg })

-- Line number and gutter customizations
hi("CursorLineNr", { fg = white_fg })
hi("DiagnosticSignError", { fg = red_fg, bg = gray_bg })
hi("DiagnosticSignHint", { fg = white_fg, bg = gray_bg })
hi("DiagnosticSignInfo", { fg = white_fg, bg = gray_bg })
hi("DiagnosticSignWarn", { fg = yellow_fg, bg = gray_bg })
hi("DiagnosticSignWarning", { fg = yellow_fg, bg = gray_bg })
hi("GitGutterAdd", { bg = gray_bg })
hi("GitGutterChange", { bg = gray_bg })
hi("GitGutterDelete", { bg = gray_bg })
hi("LineNr", { fg = gray_fg, bg = gray_bg })
hi("SignColumn", { bg = gray_bg })

local preview_ns = vim.api.nvim_create_namespace("mthadley:lsp_floating_preview")

-- Don't highlight pairs via standard `pi_paren` plugin in LSP floating previews.
clear("MatchParen", preview_ns)
