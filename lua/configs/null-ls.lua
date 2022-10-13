local ok, null_ls = pcall(require, "null-ls")
if not ok then return end
null_ls.setup({
    on_attach = require("core.lsp").on_attach
})
