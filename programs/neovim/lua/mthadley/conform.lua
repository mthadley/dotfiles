require('conform').setup({
  formatters_by_ft = {
    fish = {'fish_indent'},
    go = {'goimports', 'gofmt'},
    javascript = {'prettier'},
    mdx = {'prettier'},
    typescript = {'prettier'},
    zig = {'zigfmt'},
  },
  format_on_save = {
    lsp_fallback = true,
    timeout_ms = 500,
  },
  notify_on_error = false,
})
