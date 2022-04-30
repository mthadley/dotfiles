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
