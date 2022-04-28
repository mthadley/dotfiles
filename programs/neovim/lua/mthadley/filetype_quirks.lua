local group = vim.api.nvim_create_augroup('filetype-quirks', {
  clear = true
})

vim.api.nvim_create_autocmd('BufRead' , {
  callback = function() vim.opt_local.ft = 'jsonc' end,
  desc = 'JSON files that can have comments.',
  pattern = { 'rush.json' },
  group = group
})
