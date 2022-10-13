local ok, mason_lspconfig = pcall(require, "mason-lspconfig")
if not ok then return end
mason_lspconfig.setup({})
mason_lspconfig.setup_handlers({ function(server_name)
    require("lspconfig")[server_name].setup({
        on_attach = require("core.lsp").on_attach,
        handlers = require("core.lsp").handlers,
        flags = require("core.lsp").flags
    })
end
})
