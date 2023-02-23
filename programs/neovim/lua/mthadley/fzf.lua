local fzf = require('fzf-lua')

fzf.setup {
  winopts = {
    height = 0.4,
    row = 1,
    width = 1,

    preview = {
      horizontal = "right:50%",
      layout = 'horizontal',
    }
  },

  fzf_opts = {
    ['--layout'] = false
  },
}

vim.keymap.set('n', '<C-P>', function()
  fzf.files({
    cmd = RIPGREP_PATH
      .. ' --files | '
      .. SIMILAR_SORT_PATH
      .. ' "'
      .. vim.api.nvim_eval('expand("%")')
      .. '"',
    fzf_opts = {
      ['--tiebreak'] = 'index'
    }
  })
end, { silent = true })

vim.api.nvim_set_hl(0, "FloatBorder", { link = "Comment" })
