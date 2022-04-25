for _, mapping in ipairs({
  { "<C-G>s", ":Git<CR>" },
  { "<C-G>l", ":Glog<CR>" },
  { "<C-G>b", ":Git blame<CR>" },
  { "<C-G>h", ":Gbrowse<CR>" },
  { "<C-G>e", ":Gedit<CR>" },
}) do
  local keys, cmd = unpack(mapping)
  vim.keymap.set("n", keys, cmd)
end

local group = vim.api.nvim_create_augroup('fugitive', { clear = true })

vim.api.nvim_create_autocmd('FileType', {
  desc = 'Check spelling for Git commits.',
  pattern = 'gitcommit',
  group = group,
  callback = function(opt) vim.opt_local.spell = true end,
})