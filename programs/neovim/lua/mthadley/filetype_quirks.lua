-- pangloss/vim-javascript
vim.g.jsx_ext_required = false
vim.g.javascript_plugin_jsdoc = true

-- plasticboy/vim-markdown
vim.g.vim_markdown_folding_disabled = true
vim.g.vim_markdown_fenced_languages = { 'js=javascript', 'ini=dosini' }

local group = vim.api.nvim_create_augroup('filetype-quirks', {
  clear = true
})

vim.api.nvim_create_autocmd('BufRead' , {
  callback = function() vim.opt.ft = 'jsonc' end,
  desc = 'JSON files that can have comments',
  pattern = { 'rush.json' },
  group = group,
})

vim.api.nvim_create_autocmd({ 'BufRead', 'BufNewFile' }, {
  callback = function()
    vim.opt_local.spell = true
    vim.opt_local.textwidth = 80
  end,
  desc = 'Wrap lines when writing Markdown',
  pattern = '*.md',
  group = group,
})

vim.api.nvim_create_autocmd('BufRead', {
  callback = function() vim.opt.ft = 'gohtmltmpl' end,
  desc = 'Recognize go templates',
  pattern = '*.go.tmpl',
  group = group,
})
