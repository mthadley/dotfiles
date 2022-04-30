-- vim-test/vim-test
vim.g['test#strategy'] = 'tslime'

-- jgdavey/tslime.vim
vim.g.tslime_always_current_session = true
vim.g.tslime_always_current_window = true

vim.keymap.set('n', 'tt', ':TestFile<CR>')
vim.keymap.set('n', 'tn', ':TestNearest<CR>')
vim.keymap.set('n', 'ta', ':TestSuite<CR>')
vim.keymap.set('n', 'tl', ':execute "Tmux bundle exec rubocop " . expand("%:p")<CR>')
