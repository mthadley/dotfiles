-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local function on_attach(client, bufnr)
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  for keys, fn in pairs({
     ['<C-]>'] = vim.lsp.buf.definition,
     ['<C-k>'] = vim.lsp.buf.signature_help,
     ['<leader>ca'] = vim.lsp.buf.code_action,
     ['<leader>D'] = vim.lsp.buf.type_definition,
     ['<leader>e'] = vim.diagnostic.open_float,
     ['<leader>f'] = vim.lsp.buf.formatting,
     ['<leader>rn'] = vim.lsp.buf.rename,
     ['[d'] = vim.diagnostic.goto_prev,
     [']d'] = vim.diagnostic.goto_next,
     ['gD'] = vim.lsp.buf.declaration,
     ['gd'] = vim.lsp.buf.definition,
     ['gi'] = vim.lsp.buf.implementation,
     ['gr'] = vim.lsp.buf.references,
     ['K'] = vim.lsp.buf.hover,
  }) do
    vim.keymap.set('n', keys, fn, { buffer = bufnr })
  end
end

local language_servers = { 'tsserver' }
for _, server in pairs(language_servers) do
  require('lspconfig')[server].setup { on_attach = on_attach }
end
