for keys, cmd in pairs({
  ['<C-G>s'] = vim.cmd.Git,
  ['<C-G>l'] = vim.cmd.Gclog,
  ['<C-G>b'] = function() vim.cmd.Git('blame') end,
  ['<C-G>h'] = vim.cmd.GBrowse,
  ['<C-G>e'] = vim.cmd.Gedit,
}) do
  vim.keymap.set('n', keys, cmd)
end

local group = vim.api.nvim_create_augroup('mthadley:fugitive', { clear = true })

vim.api.nvim_create_autocmd('FileType', {
  callback = function() vim.opt_local.spell = true end,
  desc = 'Check spelling for Git commits.',
  pattern = 'gitcommit',
  group = group,
})
