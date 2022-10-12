local ok, treesitter = pcall(require, "nvim-treesitter.configs")
if not ok then return end
treesitter.setup({
    highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
        auto_install = true
    }
})
