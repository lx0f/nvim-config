local servers =
{
    "asm_lsp",
    "bashls",
    "clangd",
    "cmake",
    "cssls",
    "dockerls",
    "emmet_ls",
    "eslint",
    "graphql",
    "html",
    "jsonls",
    "kotlin_language_server",
    "sumneko_lua",
    "omnisharp",
    "prismals",
    "pyright",
    "rust_analyzer",
    "tailwindcss",
    "tsserver"
}

local border = {
    { "+", "FloatBorder" },
    { "-", "FloatBorder" },
    { "+", "FloatBorder" },
    { "|", "FloatBorder" },
    { "+", "FloatBorder" },
    { "-", "FloatBorder" },
    { "+", "FloatBorder" },
    { "|", "FloatBorder" },
}

local handlers = {
    ["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = border }),
    ["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = border })
}

local on_attach = function(client, bufnr)
    local set = vim.keymap.set
    local opts = {
        noremap = true,
        silent = true,
        nowait = true,
    }
    local capabilities = client.server_capabilities

    set("n", "<leader>ld", vim.diagnostic.open_float, opts)
    set("n", "[d", vim.diagnostic.goto_prev, opts)
    set("n", "]d", vim.diagnostic.goto_next, opts)
    set("n", "gl", vim.diagnostic.open_float, opts)

    if capabilities.codeActionProvider then
        set("n", "<leader>la", vim.lsp.buf.code_action, opts)
        set("v", "<leader>la", vim.lsp.buf.range_code_action, opts)
    end

    if capabilities.declarationProvider then
        set("n", "gD", vim.lsp.buf.declaration, opts)
    end

    if capabilities.definitionProvider then
        set("n", "gd", vim.lsp.buf.definition, opts)
    end

    if capabilities.documentFormattingProvider then
        set("n", "<leader>lf", vim.lsp.buf.format(), opts)
    end

    if capabilities.documentHighlightProvider then
        local highlight_name = vim.fn.printf("lsp_document_highlight_%d", bufnr)
        vim.api.nvim_create_augroup(highlight_name, {})
        vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
            group = highlight_name,
            buffer = bufnr,
            callback = function() vim.lsp.buf.document_highlight() end,
        })
        vim.api.nvim_create_autocmd("CursorMoved", {
            group = highlight_name,
            buffer = bufnr,
            callback = function() vim.lsp.buf.clear_references() end,
        })
    end

    if capabilities.hoverProvider then
        set("n", "K", vim.lsp.buf.hover, opts)
    end

    if capabilities.implementationProvider then
        set("n", "gI", vim.lsp.buf.implementation, opts)
    end

    if capabilities.referencesProvider then
        set("n", "gr", vim.lsp.buf.references, opts)
    end

    if capabilities.renameProvider then
        set("n", "<leader>lr", vim.lsp.buf.rename, opts)
    end

    if capabilities.signatureHelpProvider then
        set("n", "<leader>lh", vim.lsp.buf.signature_help, opts)
    end

    if capabilities.typeDefinitionProvider then
        set("n", "gT", vim.lsp.buf.type_definition, opts)
    end

end

local flags = {}

for _, server in ipairs(servers) do
    require("lspconfig")[server].setup({
        on_attach = on_attach,
        -- flags = flags,
        handlers = handlers
    })
end