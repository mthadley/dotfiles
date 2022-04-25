vim.g.neoformat_enabled_ruby = {}
vim.g.neoformat_enabled_sql = {}
vim.g.neoformat_enabled_yaml = {}
vim.g.neoformat_enabled_json = {}

local augroup = vim.api.nvim_create_augroup('fmt', { clear = true })

vim.api.nvim_create_autocmd('BufWritePre', {
  command = 'Neoformat',
  desc = 'Runs Neoformat on save.',
  group = augroup,
})
