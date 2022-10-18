local install_path = vim.fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
    PACKER_BOOTSTRAP = vim.fn.system({
        "git",
        "clone",
        "--depth",
        "1",
        "https://github.com/wbthomason/packer.nvim",
        install_path,
    })
end
local plugins = {
    ["wbthomason/packer.nvim"] = {},
    ["nvim-lua/plenary.nvim"] = { module = "plenary" },

    ["nvim-treesitter/nvim-treesitter"] = {
        config = function()
            require("configs.treesitter")
        end,
    },

    ["nvim-telescope/telescope.nvim"] = {
        cmd = "Telescope",
        module = "telescope",
        config = function()
            require("configs.telescope")
        end,
    },

    ["neovim/nvim-lspconfig"] = {},

    ["jose-elias-alvarez/null-ls.nvim"] = {},

    ["williamboman/mason.nvim"] = {
        config = function()
            require("configs.mason")
        end,
    },

    ["williamboman/mason-lspconfig.nvim"] = {
        config = function()
            require("configs.mason-lspconfig")
        end,
    },

    ["jayp0521/mason-null-ls.nvim"] = {
        config = function()
            require("configs.mason-null-ls")
        end,
    },

    ["lewis6991/gitsigns.nvim"] = {
        event = "BufEnter",
        config = function()
            require("configs.gitsigns")
        end,
    },

    ["hrsh7th/nvim-cmp"] = {
        event = "InsertEnter",
        config = function()
            require("configs.cmp")
        end
    },

    ["rafamadriz/friendly-snippets"] = { opt = true },

    ["L3MON4D3/LuaSnip"] = {
        module = "luasnip",
        wants = "friendly-snippets",
        config = function()
            require "configs.luasnip"
        end,
    },

    ["saadparwaiz1/cmp_luasnip"] = {
        after = "nvim-cmp",
    },

    ["hrsh7th/cmp-buffer"] = {
        after = "nvim-cmp"
    },

    ["hrsh7th/cmp-path"] = {
        after = "nvim-cmp"
    },

    ["hrsh7th/cmp-nvim-lsp"] = {
        after = "nvim-cmp"
    },

    ["RRethy/nvim-base16"] = {},
}
return require("packer").startup({
    function(use)
        for key, plugin in pairs(plugins) do
            plugin[1] = key
            use(plugin)
        end

        if PACKER_BOOTSTRAP then
            require("packer").sync()
        end
        use("itchyny/lightline.vim")
    end,
    config = {
        display = {
            open_fn = function()
                return require("packer.util").float({ border = "rounded" })
            end,
        },
        auto_clean = true,
        compile_on_sync = true,
    },
})
