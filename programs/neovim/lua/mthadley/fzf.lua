vim.g.fzf_colors = { border = { 'fg', 'Comment' } }
vim.g.fzf_action = {
  ['ctrl-s'] = 'split',
  ['ctrl-v'] = 'vsplit',
}

vim.keymap.set('n', '<C-P>', function()
  vim.b.fzf_wrap_options = {
    source = RIPGREP_PATH
      .. ' --files | '
      .. SIMILAR_SORT_PATH
      .. ' "'
      .. vim.api.nvim_eval('expand("%")')
      .. '"',
    options = { '--tiebreak', 'index', '--preview', FZF_VIM_PREVIEW_PATH..' {}' },
    window = {
      width = 1,
      height = 0.5,
      yoffset = 1,
    },
  }

  vim.cmd 'call fzf#run(fzf#wrap(b:fzf_wrap_options))'
end, { silent = true })
