-- Allow local prettier to run:
-- https://prettier.io/docs/en/vim.html#neoformathttpsgithubcomsbdchdneoformat
vim.g.neoformat_try_node_exe = true

vim.g.neoformat_enabled_javascript = { 'prettier', 'standard' }
vim.g.neoformat_enabled_json = {}
vim.g.neoformat_enabled_ruby = {}
vim.g.neoformat_enabled_sql = {}
vim.g.neoformat_enabled_yaml = { 'prettier' }

local augroup = vim.api.nvim_create_augroup('mthadley:neoformat', { clear = true })

vim.api.nvim_create_autocmd('BufWritePre', {
  command = 'Neoformat',
  desc = 'Runs Neoformat on save.',
  group = augroup,
})
