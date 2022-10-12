local install_path = vim.fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
    packer_bootstrap = vim.fn.system(
        {
            'git',
            'clone',
            '--depth',
            '1',
            'https://github.com/wbthomason/packer.nvim',
            install_path
        }
    )
end
local plugins = {
    ["wbthomason/packer.nvim"] = {},
    ['nvim-lua/plenary.nvim'] = { module = 'plenary' },

    ["nvim-treesitter/nvim-treesitter"] = {
        config = function()
            require("configs.treesitter")
        end
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
        end
    },

    ["williamboman/mason-lspconfig.nvim"] = {
        config = function()
            require("configs.mason-lspconfig")
        end
    },

    ["jayp0521/mason-null-ls.nvim"] = {
        config = function()
            require("configs.mason-null-ls")
        end
    },

    ["folke/which-key.nvim"] = {
        module = "which-key",
        config = function() require "configs.which-key" end,
    },

    ["RRethy/nvim-base16"] = {},
}
return require('packer').startup(
    {
        function(use)
            for key, plugin in pairs(plugins) do
                plugin[1] = key
                use(plugin)
            end

            if packer_bootstrap then
                require('packer').sync()
            end
        end,
        config = {
            display = {
                open_fn = function()
                    return require('packer.util').float { border = 'rounded' }
                end
            },
            auto_clean = true,
            compile_on_sync = true,
        },
    }
)
