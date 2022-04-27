-- Misc. Mappings
vim.keymap.set('n', '<leader>m', ':Man<CR>')

-- Toggle the Quickfix window
vim.keymap.set('n', '<leader>cw', function()
  for _, bufnr in ipairs(vim.api.nvim_list_bufs()) do
    if vim.fn.bufwinid(bufnr) ~= -1 and
      vim.api.nvim_buf_get_option(bufnr, 'buftype') == 'quickfix' then
      vim.cmd 'cclose'
      return
    end
  end

  vim.cmd 'copen'
end, { silent = true })
