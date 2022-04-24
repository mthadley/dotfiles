-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local function on_attach(client, bufnr)
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  local mappings = {
    { 'n', '<C-]>', vim.lsp.buf.definition },
    { 'n', '<C-k>', vim.lsp.buf.signature_help },
    { 'n', '<leader>ca', vim.lsp.buf.code_action },
    { 'n', '<leader>D', vim.lsp.buf.type_definition },
    { 'n', '<leader>e', vim.diagnostic.open_float },
    { 'n', '<leader>f', vim.lsp.buf.formatting },
    { 'n', '<leader>rn', vim.lsp.buf.rename },
    { 'n', '[d', vim.diagnostic.goto_prev },
    { 'n', ']d', vim.diagnostic.goto_next },
    { 'n', 'gD', vim.lsp.buf.declaration },
    { 'n', 'gd', vim.lsp.buf.definition },
    { 'n', 'gi', vim.lsp.buf.implementation },
    { 'n', 'gr', vim.lsp.buf.references },
    { 'n', 'K', vim.lsp.buf.hover },
  }

  for _, key_mapping in pairs(mappings) do
    local mode, keys, fn = unpack(key_mapping)
    vim.keymap.set(mode, keys, fn, { buffer = bufnr })
  end
end

local language_servers = { 'tsserver' }
for _, server in pairs(language_servers) do
  require('lspconfig')[server].setup { on_attach = on_attach }
end
