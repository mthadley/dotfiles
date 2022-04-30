local opt = vim.opt

opt.backup = false
opt.clipboard = "unnamedplus"
opt.completeopt:remove { "preview" }
opt.expandtab = true
opt.grepprg = RIPGREP_PATH..' --vimgrep'
opt.ignorecase = true
opt.mouse = "a"
opt.number = true
opt.relativenumber = true
opt.scrolloff = 10
opt.shiftround = true
opt.shiftwidth = 4
opt.splitbelow = true
opt.splitright = true
opt.undofile = true
opt.updatetime = 100
opt.writebackup = false

local group = vim.api.nvim_create_augroup('options', { clear = true })

opt.autoread = true
vim.api.nvim_create_autocmd('CursorHold', {
  command = 'checktime',
  desc = 'Autoreload files on change',
  group = group,
})

vim.api.nvim_create_autocmd('BufWritePre', {
  command = '%s/\\s\\+$//e',
  desc = 'Remove trailing whitespace',
  group = group,
})
