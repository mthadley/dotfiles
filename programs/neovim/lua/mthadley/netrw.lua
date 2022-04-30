-- Fix netrw mm and mc commands by updating lcd as you navigate
-- Keep everything else working by updating lcd back to the global
vim.g.netrw_keepdir = false

vim.api.nvim_create_autocmd('BufLeave', {
  command = 'exe "lcd" getcwd(-1)',
  desc = 'Fix netrw mm and mc commands.',
  group = vim.api.nvim_create_augroup('netrw', { clear = true }),
})

vim.keymap.set('n', '<C-E>e', ':Explore<CR>')
vim.keymap.set('n', '<C-E>s', ':Hexplore<CR>')
vim.keymap.set('n', '<C-E>v', ':Vexplore<CR>')
