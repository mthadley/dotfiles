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
  callback = function() vim.opt_local.textwidth = 80 end,
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
