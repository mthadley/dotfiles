-- Fix netrw mm and mc commands by updating lcd as you navigate
-- Keep everything else working by updating lcd back to the global
vim.g.netrw_keepdir = false

vim.api.nvim_create_autocmd('BufLeave', {
  callback = function() vim.cmd.lcd(vim.fn.getcwd(-1)) end,
  desc = 'Fix netrw mm and mc commands.',
  group = vim.api.nvim_create_augroup('netrw', { clear = true }),
})

vim.keymap.set('n', '<C-E>e', ':Explore<CR>')
vim.keymap.set('n', '<C-E>s', ':Hexplore<CR>')
vim.keymap.set('n', '<C-E>v', ':Vexplore<CR>')
