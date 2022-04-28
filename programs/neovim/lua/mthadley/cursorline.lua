vim.opt.cursorline = true

local group = vim.api.nvim_create_augroup('cursorline', {
  clear = true
})

vim.api.nvim_create_autocmd({ 'WinEnter', 'WinLeave', 'BufEnter', 'BufLeave' }, {
  callback = function(opts)
    vim.opt_local.cursorline =
      opts.event == 'WinEnter' or opts.event == 'BufEnter'
  end,
  desc = 'Autohide cursorline when leaving a window.',
  group = group,
})
