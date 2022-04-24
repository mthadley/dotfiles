require('gitsigns').setup {
  on_attach = function(bufnr)
    local gs = package.loaded.gitsigns

    local mappings = {
      {  'n', '<C-G>d', gs.diffthis},
      { { 'n', 'v', }, '<C-G>a', ':Gitsigns stage_hunk<CR>'},
      { { 'n', 'v', }, '<C-G>x', ':Gitsigns reset_hunk<CR>'},
    }

    for _, mapping in ipairs(mappings) do
      local mode, keys, fn = unpack(mapping)
      vim.keymap.set(mode, keys, fn, { buffer = bufnr })
    end
  end
}
