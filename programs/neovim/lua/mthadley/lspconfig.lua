local key_opts = { noremap = true, silent = true }

vim.api.nvim_set_keymap('n', '<leader>e', '<cmd>lua vim.diagnostic.open_float()<CR>', key_opts)
vim.api.nvim_set_keymap('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>', key_opts)
vim.api.nvim_set_keymap('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<CR>', key_opts)

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local function on_attach(client, bufnr)
  -- Enable completion triggered by <c-x><c-o>
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  local mappings = {
    { 'n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>' },
    { 'n', '<leader>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>' },
    { 'n', '<leader>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>' },
    { 'n', '<leader>f', '<cmd>lua vim.lsp.buf.formatting()<CR>' },
    { 'n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>' },
    { 'n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>' },
    { 'n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>' },
    { 'n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>' },
    { 'n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>' },
    { 'n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>' },
  }

  for _, key_mapping in pairs(mappings) do
    local mode, keys, cmd = unpack(key_mapping)
    vim.api.nvim_buf_set_keymap(bufnr, mode, keys, cmd, key_opts)
  end
end

local language_servers = { 'tsserver' }
for _, server in pairs(language_servers) do
  require('lspconfig')[server].setup { on_attach = on_attach }
end
