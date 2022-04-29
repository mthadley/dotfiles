-- chriskempson/base16-vim
vim.g.base16colorspace = 256

vim.opt.termguicolors = true
vim.cmd 'colorscheme base16-ocean'

vim.api.nvim_set_hl(0, 'CursorLineNr', { cterm = { bold = true } })

-- LSP-related Colors
vim.cmd "highlight! link DiagnosticError ErrorMsg"
vim.cmd "highlight! link DiagnosticWarn WarningMsg"
vim.cmd "highlight! link DiagnosticInfo MoreMsg"

local diagnostic_sign_colors = {
  DiagnosticSignError = vim.g.base16_gui08,
  DiagnosticSignHint = vim.g.base16_gui05,
  DiagnosticSignWarning = vim.g.base16_gui09,
}

for group, fg in pairs(diagnostic_sign_colors) do
  vim.api.nvim_set_hl(0, group, { fg = '#'..fg, bg = '#'..vim.g.base16_gui01 })
end
